import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/playlist.dart';
import '../../core/models/playlist_item.dart';
import '../../core/models/track.dart';
import '../../data/repositories/playlist_repository.dart';
import '../../data/repositories/track_repository.dart';
import '../../services/sync/sync_service.dart';

class PlaylistDetailEntry {
  const PlaylistDetailEntry({required this.item, this.track});

  final PlaylistItem item;
  final Track? track;
}

class PlaylistDetailController
    extends StateNotifier<AsyncValue<List<PlaylistDetailEntry>>> {
  PlaylistDetailController(this._playlistId, this._playlistRepo, this._trackRepo, this._sync)
      : super(const AsyncValue.loading()) {
    _load();
  }

  final String _playlistId;
  final PlaylistRepository _playlistRepo;
  final TrackRepository _trackRepo;
  final SyncService _sync;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final items = await _playlistRepo.getLocalItems(_playlistId);
      final entries = <PlaylistDetailEntry>[];
      for (final item in items) {
        final track = await _trackRepo.getTrack(item.trackId);
        entries.add(PlaylistDetailEntry(item: item, track: track));
      }
      state = AsyncValue.data(entries);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() => _load();

  Future<void> removeItem(String itemId) async {
    await _sync.deletePlaylistItem(itemId);
    await _load();
  }

  Future<void> addTrack(Playlist playlist, Track track) async {
    await _sync.addTrackToPlaylist(playlist: playlist, track: track);
    await _load();
  }
}

final playlistDetailControllerProvider = StateNotifierProvider.family<PlaylistDetailController,
    AsyncValue<List<PlaylistDetailEntry>>, String>((ref, playlistId) {
  return PlaylistDetailController(
    playlistId,
    ref.watch(playlistRepositoryProvider),
    ref.watch(trackRepositoryProvider),
    ref.watch(syncServiceProvider),
  );
});

final playlistProvider = FutureProvider.family<Playlist?, String>((ref, playlistId) {
  return ref.watch(playlistRepositoryProvider).getPlaylist(playlistId);
});
