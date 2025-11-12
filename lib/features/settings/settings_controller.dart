import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/user_settings.dart';
import '../../services/integrations/lastfm_service.dart';
import '../../services/sync/sync_service.dart';

class SettingsController extends StateNotifier<AsyncValue<UserSettings>> {
  SettingsController(this._sync, this._lastFm) : super(const AsyncValue.loading()) {
    _load();
  }

  final SyncService _sync;
  final LastFmService _lastFm;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final settings = await _sync.loadOrCreateSettings();
      state = AsyncValue.data(settings);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> toggleNormalize(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.copyWith(normalizeVolume: value);
    await _sync.saveSettings(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> updateCrossfade(int milliseconds) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.copyWith(crossfadeMs: milliseconds);
    await _sync.saveSettings(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> enableLastFmScrobbling({String? username, String? password}) async {
    final current = state.valueOrNull;
    if (current == null) return;
    if (!_lastFm.isConfigured) {
      throw StateError('LASTFM_API_KEY/LASTFM_API_SECRET não configurados no .env');
    }
    var sessionKey = current.lastFmSessionKey;
    var lastFmUsername = current.lastFmUsername;
    if (sessionKey == null || sessionKey.isEmpty) {
      if (username == null || username.isEmpty || password == null || password.isEmpty) {
        throw StateError('Informe usuário e senha do Last.fm para conectar');
      }
      sessionKey = await _lastFm.createSession(username: username, password: password);
      lastFmUsername = username;
    }
    final updated = current.copyWith(
      scrobbleToLastFm: true,
      lastFmSessionKey: sessionKey,
      lastFmUsername: lastFmUsername,
    );
    await _sync.saveSettings(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> disableLastFmScrobbling() async {
    final current = state.valueOrNull;
    if (current == null) return;
    if (!current.scrobbleToLastFm) return;
    final updated = current.copyWith(scrobbleToLastFm: false);
    await _sync.saveSettings(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> disconnectLastFm() async {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.copyWith(
      scrobbleToLastFm: false,
      lastFmSessionKey: null,
      lastFmUsername: null,
    );
    await _sync.saveSettings(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> refresh() => _load();

  Future<void> signOut() => _sync.signOut();
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<UserSettings>>((ref) {
  return SettingsController(ref.watch(syncServiceProvider), ref.watch(lastFmServiceProvider));
});
