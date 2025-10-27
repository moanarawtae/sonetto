import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/playlist.dart';
import '../../data/repositories/track_repository.dart';
import '../../services/audio/player_service.dart';
import 'playlist_detail_controller.dart';

class PlaylistDetailPage extends ConsumerWidget {
  const PlaylistDetailPage({required this.playlistId, super.key});

  final String playlistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistAsync = ref.watch(playlistProvider(playlistId));
    final entriesAsync = ref.watch(playlistDetailControllerProvider(playlistId));
    return Scaffold(
      appBar: AppBar(
        title: playlistAsync.when(
          data: (playlist) => Text(playlist?.name ?? 'playlist'),
          loading: () => const Text('carregando'),
          error: (_, __) => const Text('playlist'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final playlist = playlistAsync.value;
              if (playlist != null) {
                await _showAddTrackSheet(context, ref, playlist);
              }
            },
          ),
        ],
      ),
      body: entriesAsync.when(
        data: (entries) => _PlaylistItemsList(entries: entries),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('erro: $error')),
      ),
    );
  }

  Future<void> _showAddTrackSheet(BuildContext context, WidgetRef ref, Playlist playlist) async {
    final tracks = await ref.read(trackRepositoryProvider).getLocalTracks();
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final track = tracks[index];
          return ListTile(
            title: Text(track.title),
            subtitle: Text(track.artist),
            onTap: () async {
              await ref
                  .read(playlistDetailControllerProvider(playlistId).notifier)
                  .addTrack(playlist, track);
              if (context.mounted) Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

class _PlaylistItemsList extends ConsumerWidget {
  const _PlaylistItemsList({required this.entries});

  final List<PlaylistDetailEntry> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (entries.isEmpty) {
      return const Center(child: Text('adicione faixas à playlist'));
    }
    final player = ref.watch(playerServiceProvider);
    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final entry = entries[index];
        final track = entry.track;
        return ListTile(
          title: Text(track?.title ?? 'faixa removida'),
          subtitle: Text(track != null ? '${track.artist} · ${track.album}' : 'indisponível'),
          onTap: track == null ? null : () => player.playTrack(track),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await ref
                  .read(playlistDetailControllerProvider(entry.item.playlistId).notifier)
                  .removeItem(entry.item.id);
            },
          ),
        );
      },
    );
  }
}
