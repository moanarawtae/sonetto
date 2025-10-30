import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';
import '../../data/repositories/track_repository.dart';

class LibraryController extends StateNotifier<AsyncValue<List<Track>>> {
  LibraryController(this._tracks) : super(const AsyncValue.loading()) {
    _subscribe();
  }

  final TrackRepository _tracks;
  String _query = '';
  StreamSubscription<List<Track>>? _subscription;

  void _subscribe() {
    state = const AsyncValue.loading();
    _subscription?.cancel();
    _subscription = _tracks.watchLocalTracks(_query).listen(
      (tracks) => state = AsyncValue.data(tracks),
      onError: (error, stack) => state = AsyncValue.error(error, stack),
    );
  }

  Future<void> refresh() async {
    _subscribe();
  }

  Future<void> search(String query) async {
    _query = query;
    _subscribe();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final libraryControllerProvider =
    StateNotifierProvider<LibraryController, AsyncValue<List<Track>>>((ref) {
  return LibraryController(ref.watch(trackRepositoryProvider));
});
