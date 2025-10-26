import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/playlist.dart';
import '../../data/repositories/playlist_repository.dart';
import '../../services/sync/sync_service.dart';

class PlaylistsController extends StateNotifier<AsyncValue<List<Playlist>>> {
  PlaylistsController(this._repo, this._sync) : super(const AsyncValue.loading()) {
    _load();
  }

  final PlaylistRepository _repo;
  final SyncService _sync;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repo.getLocalPlaylists();
      state = AsyncValue.data(data);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() => _load();

  Future<void> create(String name) async {
    await _sync.createPlaylist(name);
    await _load();
  }

  Future<void> rename(Playlist playlist, String name) async {
    await _sync.renamePlaylist(playlist, name);
    await _load();
  }

  Future<void> delete(String id) async {
    await _sync.deletePlaylist(id);
    await _load();
  }
}

final playlistsControllerProvider =
    StateNotifierProvider<PlaylistsController, AsyncValue<List<Playlist>>>((ref) {
  return PlaylistsController(ref.watch(playlistRepositoryProvider), ref.watch(syncServiceProvider));
});
