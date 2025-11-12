import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:uuid/uuid.dart';

import '../../core/models/track.dart';
import '../../data/repositories/track_repository.dart';
import '../../data/remote/supabase_service.dart';
import 'yt_dlp_service.dart';

final importServiceProvider = Provider<ImportService>((ref) {
  final service = ImportService(
    ref.watch(trackRepositoryProvider),
    ref.watch(supabaseServiceProvider),
    const Uuid(),
    ref.watch(ytDlpServiceProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

class ImportService {
  ImportService(this._tracks, this._supabase, this._uuid, this._ytDlp);

  final TrackRepository _tracks;
  final SupabaseService _supabase;
  final Uuid _uuid;
  final YtDlpService _ytDlp;

  Future<Track> importTrack(String url) async {
    if (_isSpotifyUrl(url)) {
      final metadata = await _fetchSpotifyMetadata(url);
      final video =
          await _ytDlp.searchFirst('${metadata.title} ${metadata.artist}');
      return _downloadAndStore(video, metadata: metadata);
    }

    if (_isYoutubeUrl(url)) {
      final video = await _ytDlp.getVideo(url);
      return _downloadAndStore(video);
    }

    throw UnsupportedError('URL não suportada: $url');
  }

  Future<Track> _downloadAndStore(YtDlpVideo video,
      {TrackMetadata? metadata}) async {
    final download = await _ytDlp.downloadBestAudio(video.url);

    final docsDir = await getApplicationDocumentsDirectory();
    final tracksDir = Directory(p.join(docsDir.path, 'tracks'));
    if (!await tracksDir.exists()) {
      await tracksDir.create(recursive: true);
    }
    final outputPath = p.join(tracksDir.path, '${_uuid.v4()}.mp3');

    try {
      final command = [
        '-y',
        '-i',
        download.file.path,
        '-vn',
        '-acodec',
        'libmp3lame',
        '-qscale:a',
        '2',
        outputPath,
      ].map(_escapeArgument).join(' ');

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      if (!ReturnCode.isSuccess(returnCode)) {
        final fail = await session.getFailStackTrace();
        throw Exception('Falha ao converter áudio: $fail');
      }
    } finally {
      await download.cleanup();
    }

    final userId = _supabase.client.auth.currentUser?.id ?? 'local';
    final now = DateTime.now().toUtc();
    final track = Track(
      id: _uuid.v4(),
      title: metadata?.title ?? video.title,
      artist: metadata?.artist ?? video.channel,
      album: metadata?.album ?? metadata?.artist ?? video.channel,
      durationMs: metadata?.durationMs ?? video.duration?.inMilliseconds ?? 0,
      sourceUrl: video.url.isNotEmpty
          ? video.url
          : 'https://www.youtube.com/watch?v=${video.id}',
      artworkUrl: metadata?.artworkUrl ?? video.thumbnailUrl,
      localPath: outputPath,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );

    await _tracks.addLocalTrack(track);
    return track;
  }

  Future<TrackMetadata> _fetchSpotifyMetadata(String url) async {
    final trackId = _extractSpotifyTrackId(url);
    if (trackId == null) {
      throw ArgumentError('URL do Spotify inválida: $url');
    }

    final clientId = dotenv.env['SPOTIFY_CLIENT_ID'];
    final clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET'];
    if (clientId == null || clientSecret == null) {
      throw StateError(
          'Configure SPOTIFY_CLIENT_ID e SPOTIFY_CLIENT_SECRET no arquivo .env');
    }

    final credentials = spotify.SpotifyApiCredentials(clientId, clientSecret);
    final spotifyApi = spotify.SpotifyApi(credentials);
    final track = await spotifyApi.tracks.get(trackId);

    final artistName =
        track.artists?.firstOrNull?.name ?? 'artista desconhecido';
    final albumName = track.album?.name ?? 'álbum desconhecido';
    final artworkUrl = track.album?.images?.isNotEmpty == true
        ? track.album!.images!.first.url
        : null;

    return TrackMetadata(
      title: track.name ?? 'faixa sem título',
      artist: artistName,
      album: albumName,
      durationMs: track.durationMs ?? track.duration?.inMilliseconds ?? 0,
      artworkUrl: artworkUrl,
    );
  }

  bool _isYoutubeUrl(String url) {
    if (_isYoutubeVideoId(url)) {
      return true;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final host = uri.host.toLowerCase();
    return host.contains('youtube.com') || host.contains('youtu.be');
  }

  bool _isSpotifyUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host != 'open.spotify.com') return false;
    final segments = List<String>.from(
        uri.pathSegments.where((segment) => segment.isNotEmpty));
    if (segments.isEmpty) return false;
    if (segments.first.startsWith('intl-')) {
      segments.removeAt(0);
    }
    return segments.isNotEmpty && segments.first == 'track';
  }

  String? _extractSpotifyTrackId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host != 'open.spotify.com') return null;
    final segments = List<String>.from(
        uri.pathSegments.where((segment) => segment.isNotEmpty));
    if (segments.isEmpty) return null;
    if (segments.first.startsWith('intl-')) {
      segments.removeAt(0);
    }
    if (segments.isEmpty || segments.first != 'track') return null;
    return segments.length >= 2 ? segments[1] : null;
  }

  String _escapeArgument(String input) {
    if (input.contains(' ')) {
      return '"${input.replaceAll('"', r'\"')}"';
    }
    return input;
  }

  bool _isYoutubeVideoId(String value) {
    final regex = RegExp(r'^[a-zA-Z0-9_-]{11}$');
    return regex.hasMatch(value);
  }

  Future<void> dispose() async {}
}

class TrackMetadata {
  TrackMetadata({
    required this.title,
    required this.artist,
    required this.album,
    required this.durationMs,
    this.artworkUrl,
  });

  final String title;
  final String artist;
  final String album;
  final int durationMs;
  final String? artworkUrl;
}
