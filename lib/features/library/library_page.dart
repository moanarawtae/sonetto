import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';
import '../../services/audio/player_service.dart';
import '../../services/import/import_service.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) => const _ImportTrackSheet(),
        ),
        icon: const Icon(Icons.download),
        label: const Text('importar'),
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

class _ImportTrackSheet extends ConsumerStatefulWidget {
  const _ImportTrackSheet();

  @override
  ConsumerState<_ImportTrackSheet> createState() => _ImportTrackSheetState();
}

class _ImportTrackSheetState extends ConsumerState<_ImportTrackSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _statusMessage;
  bool _statusSuccess = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleImport() async {
    final url = _controller.text.trim();
    if (url.isEmpty) {
      setState(() {
        _statusMessage = 'Cole um link do YouTube ou Spotify.';
        _statusSuccess = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = null;
      _statusSuccess = false;
    });

    try {
      final track = await ref.read(importServiceProvider).importTrack(url);
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Música "${track.title}" descarregada!';
        _statusSuccess = true;
        _controller.clear();
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Erro: ${error.toString()}';
        _statusSuccess = false;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: bottomInset + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'importar faixa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'URL do YouTube ou Spotify',
              hintText: 'cole aqui o link',
            ),
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (!_isLoading) {
                _handleImport();
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _handleImport,
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(_isLoading ? 'processando...' : 'descarregar'),
            ),
          ),
          if (_statusMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _statusMessage!,
              style: TextStyle(
                color: _statusSuccess ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
