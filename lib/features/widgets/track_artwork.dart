import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class TrackArtwork extends StatelessWidget {
  const TrackArtwork({
    super.key,
    required this.size,
    this.artworkUrl,
    this.borderRadius,
  });

  final double size;
  final String? artworkUrl;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(size * 0.15);
    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        width: size,
        height: size,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final art = artworkUrl;
    if (art == null || art.isEmpty) {
      return _placeholder(context);
    }

    if (_isDataUri(art)) {
      final dataIndex = art.indexOf(',');
      if (dataIndex != -1) {
        final encoded = art.substring(dataIndex + 1);
        try {
          final bytes = base64Decode(encoded);
          return Image.memory(bytes, fit: BoxFit.cover);
        } catch (_) {
          return _placeholder(context);
        }
      }
    }

    final uri = Uri.tryParse(art);
    if (uri != null && uri.hasScheme) {
      if (uri.scheme == 'http' || uri.scheme == 'https') {
        return Image.network(
          art,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(context),
        );
      }
      if (uri.scheme == 'file') {
        return _buildFileImage(uri.toFilePath(), context);
      }
    }

    return _buildFileImage(art, context);
  }

  Widget _buildFileImage(String path, BuildContext context) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(context),
        );
      }
    } catch (_) {
      // Ignored: fall back to placeholder.
    }
    return _placeholder(context);
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(Icons.album, size: size * 0.5),
    );
  }

  bool _isDataUri(String value) {
    return value.startsWith('data:image');
  }
}
