import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/models/track.dart';
import '../../core/models/user_settings.dart';
import '../../data/repositories/settings_repository.dart';
import '../integrations/lastfm_service.dart';
import 'player_service.dart';

class PlaybackTracker {
  PlaybackTracker(this._player, this._settingsRepository, this._lastFm);

  final PlayerService _player;
  final SettingsRepository _settingsRepository;
  final LastFmService _lastFm;

  StreamSubscription<SequenceState?>? _sequenceSub;
  StreamSubscription<Duration?>? _positionSub;
  StreamSubscription<UserSettings?>? _settingsSub;

  Track? _currentTrack;
  DateTime? _trackStartedAt;
  bool _scrobbleSent = false;
  UserSettings? _settings;

  void init() {
    _settingsSub = _settingsRepository.watchLocal().listen((settings) {
      _settings = settings;
    });
    _sequenceSub = _player.sequenceState.listen(_handleSequence);
    _positionSub = _player.positionStream.listen(_handlePosition);
  }

  Future<void> dispose() async {
    await _sequenceSub?.cancel();
    await _positionSub?.cancel();
    await _settingsSub?.cancel();
  }

  void _handleSequence(SequenceState? state) {
    final track = state?.currentSource?.tag as Track?;
    if (track == null) {
      _reset();
      return;
    }
    if (_currentTrack?.id == track.id) {
      return;
    }
    _startTrack(track);
  }

  void _reset() {
    _currentTrack = null;
    _trackStartedAt = null;
    _scrobbleSent = false;
  }

  void _startTrack(Track track) {
    _currentTrack = track;
    _trackStartedAt = DateTime.now().toUtc();
    _scrobbleSent = false;
    if (_canScrobble) {
      unawaited(_lastFm
          .updateNowPlaying(
              track: track, sessionKey: _settings!.lastFmSessionKey!)
          .catchError(
              (error, _) => debugPrint('Last.fm now playing erro: $error')));
    }
  }

  void _handlePosition(Duration? position) {
    if (position == null) return;
    if (!_canScrobble || _currentTrack == null || _scrobbleSent) {
      return;
    }
    final thresholdSeconds = _scrobbleThresholdSeconds(_currentTrack!);
    if (position.inSeconds >= thresholdSeconds) {
      _scrobbleSent = true;
      final startedAt =
          _trackStartedAt ?? DateTime.now().toUtc().subtract(position);
      unawaited(_lastFm
          .scrobble(
              track: _currentTrack!,
              startedAt: startedAt,
              sessionKey: _settings!.lastFmSessionKey!)
          .catchError((error, _) {
        debugPrint('Last.fm scrobble erro: $error');
        _scrobbleSent = false;
      }));
    }
  }

  bool get _canScrobble {
    final settings = _settings;
    if (settings == null) return false;
    final key = settings.lastFmSessionKey;
    if (!_lastFm.isConfigured) return false;
    return settings.scrobbleToLastFm && key != null && key.isNotEmpty;
  }

  int _scrobbleThresholdSeconds(Track track) {
    final durationSeconds =
        track.durationMs > 0 ? (track.durationMs / 1000).floor() : 0;
    if (durationSeconds <= 0) {
      return 240;
    }
    final half = (durationSeconds / 2).floor();
    final minValue = math.min(half, 240);
    return math.max(minValue, 30);
  }
}

final playbackTrackerProvider = Provider<PlaybackTracker>((ref) {
  final tracker = PlaybackTracker(
    ref.watch(playerServiceProvider),
    ref.watch(settingsRepositoryProvider),
    ref.watch(lastFmServiceProvider),
  );
  tracker.init();
  ref.onDispose(tracker.dispose);
  return tracker;
});
