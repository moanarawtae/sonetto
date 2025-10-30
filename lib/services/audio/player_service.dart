import 'package:audio_session/audio_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/models/track.dart';
import '../../data/repositories/settings_repository.dart';

class PlayerService {
  PlayerService(this._player, this._settingsRepository);

  final AudioPlayer _player;
  final SettingsRepository _settingsRepository;

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    final settings = await _settingsRepository.loadLocal();
    if (settings != null) {
      await _player.setVolume(settings.normalizeVolume ? 0.9 : 1);
    }
  }

  Stream<Duration?> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<PlayerState> get playerState => _player.playerStateStream;
  Stream<SequenceState?> get sequenceState => _player.sequenceStateStream;

  Future<void> loadTracks(List<Track> tracks) async {
    final sources = tracks
        .map(
          (track) => AudioSource.uri(
            track.localPath != null && track.localPath!.isNotEmpty
                ? Uri.file(track.localPath!)
                : Uri.parse(track.sourceUrl),
            tag: track,
          ),
        )
        .toList();
    final playlist = ConcatenatingAudioSource(children: sources);
    await _player.setAudioSource(playlist);
  }

  Future<void> playTrack(Track track, {List<Track>? queue}) async {
    if (queue != null) {
      await loadTracks(queue);
    } else if (_player.sequenceState == null) {
      await loadTracks([track]);
    }
    final index = queue?.indexWhere((t) => t.id == track.id) ?? 0;
    await _player.seek(Duration.zero, index: index);
    await _player.play();
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> next() => _player.seekToNext();

  Future<void> previous() => _player.seekToPrevious();

  Future<void> dispose() => _player.dispose();
}

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  final player = AudioPlayer();
  ref.onDispose(player.dispose);
  return player;
});

final playerServiceProvider = Provider<PlayerService>((ref) {
  final service = PlayerService(
    ref.watch(audioPlayerProvider),
    ref.watch(settingsRepositoryProvider),
  );
  service.init();
  ref.onDispose(service.dispose);
  return service;
});
