import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/playlist.dart';
import 'playlists_controller.dart';

class PlaylistsPage extends ConsumerWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsAsync = ref.watch(playlistsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('playlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context, ref),
          ),
        ],
      ),
      body: playlistsAsync.when(
        data: (playlists) => _PlaylistsList(playlists: playlists),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('erro: $error')),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('nova playlist'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'nome'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('criar')),
        ],
      ),
    );
    if (confirmed == true && controller.text.isNotEmpty) {
      await ref.read(playlistsControllerProvider.notifier).create(controller.text);
    }
  }
}

class _PlaylistsList extends ConsumerWidget {
  const _PlaylistsList({required this.playlists});

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (playlists.isEmpty) {
      return const Center(child: Text('nenhuma playlist ainda'));
    }
    return ListView.separated(
      itemCount: playlists.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return ListTile(
          title: Text(playlist.name),
          onTap: () => context.go('/playlists/${playlist.id}'),
          trailing: PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'renomear') {
                await _rename(context, ref, playlist);
              } else if (value == 'remover') {
                await ref.read(playlistsControllerProvider.notifier).delete(playlist.id);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'renomear', child: Text('renomear')),
              PopupMenuItem(value: 'remover', child: Text('remover')),
            ],
          ),
        );
      },
    );
  }

  Future<void> _rename(BuildContext context, WidgetRef ref, Playlist playlist) async {
    final controller = TextEditingController(text: playlist.name);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('renomear playlist'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('salvar')),
        ],
      ),
    );
    if (confirmed == true && controller.text.isNotEmpty) {
      await ref.read(playlistsControllerProvider.notifier).rename(playlist, controller.text);
    }
  }
}
