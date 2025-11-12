import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/track.dart';
import '../../../services/sync/sync_service.dart';
import '../../widgets/track_artwork.dart';

class EditTrackSheet extends ConsumerStatefulWidget {
  const EditTrackSheet({super.key, required this.track});

  final Track track;

  @override
  ConsumerState<EditTrackSheet> createState() => _EditTrackSheetState();
}

class _EditTrackSheetState extends ConsumerState<EditTrackSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _artistController;
  late final TextEditingController _albumController;
  late final TextEditingController _artworkController;
  late final VoidCallback _artworkListener;

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.track.title);
    _artistController = TextEditingController(text: widget.track.artist);
    _albumController = TextEditingController(text: widget.track.album);
    _artworkController =
        TextEditingController(text: widget.track.artworkUrl ?? '');
    _artworkListener = () => setState(() {});
    _artworkController.addListener(_artworkListener);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _artworkController.removeListener(_artworkListener);
    _artworkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final artworkPreview = _artworkController.text.trim().isEmpty
        ? widget.track.artworkUrl
        : _artworkController.text.trim();
    return Padding(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: 16, bottom: bottomInset + 24),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'personalizar faixa',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    TrackArtwork(
                      size: 120,
                      artworkUrl: artworkPreview,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      artworkPreview == null || artworkPreview.isEmpty
                          ? 'sem capa'
                          : 'pré-visualização',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'nome da música',
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'informe um título';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(
                  labelText: 'artista',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'informe o artista';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _albumController,
                decoration: const InputDecoration(
                  labelText: 'álbum',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'informe o álbum';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _artworkController,
                decoration: InputDecoration(
                  labelText: 'link da capa (opcional)',
                  suffixIcon: _artworkController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'remover capa',
                          onPressed: _isSaving
                              ? null
                              : () {
                                  _artworkController.clear();
                                },
                          icon: const Icon(Icons.clear),
                        ),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              Text(
                'Aceita links http(s) ou deixe em branco para usar a capa original.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _handleSave,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(_isSaving ? 'salvando...' : 'salvar alterações'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    final sync = ref.read(syncServiceProvider);
    final trimmedArtwork = _artworkController.text.trim();
    final updated = widget.track.copyWith(
      title: _titleController.text.trim(),
      artist: _artistController.text.trim(),
      album: _albumController.text.trim(),
      artworkUrl: trimmedArtwork.isEmpty ? null : trimmedArtwork,
      updatedAt: DateTime.now().toUtc(),
    );

    try {
      await sync.upsertTrack(updated);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _errorMessage = 'erro ao salvar: $error';
      });
    }
  }
}
