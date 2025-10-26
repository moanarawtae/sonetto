import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';
import '../../services/audio/player_service.dart';
import '../../services/sync/sync_service.dart';
import 'library_controller.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksAsync = ref.watch(libraryControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('biblioteca'),
        actions: [
          IconButton(
            onPressed: () => ref.read(libraryControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'buscar faixas'),
              onChanged: (value) => ref.read(libraryControllerProvider.notifier).search(value),
            ),
          ),
        ),
      ),
      body: tracksAsync.when(
        data: (tracks) => _LibraryList(tracks: tracks),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('erro: $error')),
      ),
    );
  }
}

class _LibraryList extends ConsumerWidget {
  const _LibraryList({required this.tracks});

  final List<Track> tracks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tracks.isEmpty) {
      return const Center(child: Text('nenhuma faixa local'));
    }
    final player = ref.watch(playerServiceProvider);
    return ListView.separated(
      itemCount: tracks.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final track = tracks[index];
        return ListTile(
          title: Text(track.title),
          subtitle: Text('${track.artist} · ${track.album}'),
          onTap: () => player.playTrack(track, queue: tracks),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await ref.read(syncServiceProvider).deleteTrack(track);
              await ref.read(libraryControllerProvider.notifier).refresh();
            },
          ),
        );
      },
    );
  }
}
