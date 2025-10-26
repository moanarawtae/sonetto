import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';
import '../../data/repositories/track_repository.dart';

class LibraryController extends StateNotifier<AsyncValue<List<Track>>> {
  LibraryController(this._tracks) : super(const AsyncValue.loading()) {
    _load();
  }

  final TrackRepository _tracks;
  String _query = '';

  Future<void> _load() async {
    state = const AsyncValue.loading();
    try {
      final data = await _tracks.searchLocal(_query);
      state = AsyncValue.data(data);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() => _load();

  Future<void> search(String query) async {
    _query = query;
    await _load();
  }
}

final libraryControllerProvider =
    StateNotifierProvider<LibraryController, AsyncValue<List<Track>>>((ref) {
  return LibraryController(ref.watch(trackRepositoryProvider));
});
