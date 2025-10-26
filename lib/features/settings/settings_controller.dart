import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/user_settings.dart';
import '../../services/sync/sync_service.dart';

class SettingsController extends StateNotifier<AsyncValue<UserSettings>> {
  SettingsController(this._sync) : super(const AsyncValue.loading()) {
    _load();
  }

  final SyncService _sync;

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

  Future<void> refresh() => _load();

  Future<void> signOut() => _sync.signOut();
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<UserSettings>>((ref) {
  return SettingsController(ref.watch(syncServiceProvider));
});
