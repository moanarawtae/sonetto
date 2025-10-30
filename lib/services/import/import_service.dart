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
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../core/models/track.dart';
import '../../data/repositories/track_repository.dart';
import '../../data/remote/supabase_service.dart';

final importServiceProvider = Provider<ImportService>((ref) {
  final service = ImportService(
    ref.watch(trackRepositoryProvider),
    ref.watch(supabaseServiceProvider),
    const Uuid(),
  );
  ref.onDispose(service.dispose);
  return service;
});

class ImportService {
  ImportService(this._tracks, this._supabase, this._uuid) : _youtube = YoutubeExplode();

  final TrackRepository _tracks;
  final SupabaseService _supabase;
  final Uuid _uuid;
  final YoutubeExplode _youtube;

  bool _disposed = false;

  Future<Track> importTrack(String url) async {
    if (_isSpotifyUrl(url)) {
      final metadata = await _fetchSpotifyMetadata(url);
      final video = await _findYoutubeVideo('${metadata.title} ${metadata.artist}');
      return _downloadAndStore(video, metadata: metadata);
    }

    if (_isYoutubeUrl(url)) {
      final videoId = VideoId.parseVideoId(url) ?? url;
      final video = await _youtube.videos.get(videoId);
      return _downloadAndStore(video);
    }

    throw UnsupportedError('URL não suportada: $url');
  }

  Future<Track> _downloadAndStore(Video video, {TrackMetadata? metadata}) async {
    final manifest = await _loadStreamManifest(video);

    final audioStream = manifest.audioOnly.isNotEmpty
        ? manifest.audioOnly.withHighestBitrate()
        : (manifest.muxed.isNotEmpty ? manifest.muxed.withHighestBitrate() : null);
    if (audioStream == null) {
      throw StateError('Nenhum stream de áudio disponível para ${video.id.value}');
    }
    final tempDir = await getTemporaryDirectory();
    final tempFile = File(p.join(tempDir.path, '${video.id.value}.${audioStream.container.name}'));
    final audioDownload = _youtube.videos.streamsClient.get(audioStream);
    final sink = tempFile.openWrite();
    await audioDownload.pipe(sink);
    await sink.close();

    final docsDir = await getApplicationDocumentsDirectory();
    final tracksDir = Directory(p.join(docsDir.path, 'tracks'));
    if (!await tracksDir.exists()) {
      await tracksDir.create(recursive: true);
    }
    final outputPath = p.join(tracksDir.path, '${_uuid.v4()}.mp3');

    final command = [
      '-y',
      '-i',
      tempFile.path,
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

    if (await tempFile.exists()) {
      await tempFile.delete();
    }

    final userId = _supabase.client.auth.currentUser?.id ?? 'local';
    final now = DateTime.now().toUtc();
    final track = Track(
      id: _uuid.v4(),
      title: metadata?.title ?? video.title,
      artist: metadata?.artist ?? video.author,
      album: metadata?.album ?? metadata?.artist ?? video.author,
      durationMs: metadata?.durationMs ?? video.duration?.inMilliseconds ?? 0,
      sourceUrl: 'https://www.youtube.com/watch?v=${video.id.value}',
      artworkUrl: metadata?.artworkUrl ?? video.thumbnails.standardResUrl,
      localPath: outputPath,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );

    await _tracks.addLocalTrack(track);
    return track;
  }

  Future<StreamManifest> _loadStreamManifest(Video video) async {
    final clients = [
      YoutubeApiClient.ios,
      YoutubeApiClient.androidMusic,
      YoutubeApiClient.androidVr,
    ];
    final errors = <Object>[];

    for (final client in clients) {
      try {
        final manifest = await _youtube.videos.streamsClient.getManifest(
          video.id,
          ytClients: [client],
        );
        final hasAudio = manifest.audioOnly.isNotEmpty || manifest.muxed.isNotEmpty;
        if (hasAudio) {
          return manifest;
        }
        errors.add(
          StateError('Manifesto sem áudio com client ${client.payload['context']['client']['clientName']}'),
        );
      } on YoutubeExplodeException catch (e) {
        errors.add(e);
      } catch (e) {
        errors.add(e);
      }
    }

    if (errors.isNotEmpty) {
      final reasons = errors.map((error) {
        if (error case YoutubeExplodeException(:final message)) {
          return message.trim();
        }
        return error.toString().trim();
      }).where((message) => message.isNotEmpty).join(' | ');
      throw StateError(
        reasons.isEmpty
            ? 'Não foi possível obter streams de áudio para ${video.id.value}'
            : 'Não foi possível obter streams de áudio para ${video.id.value}: $reasons',
      );
    }

    throw StateError('Não foi possível obter streams de áudio para ${video.id.value}');
  }

  Future<TrackMetadata> _fetchSpotifyMetadata(String url) async {
    final trackId = _extractSpotifyTrackId(url);
    if (trackId == null) {
      throw ArgumentError('URL do Spotify inválida: $url');
    }

    final clientId = dotenv.env['SPOTIFY_CLIENT_ID'];
    final clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET'];
    if (clientId == null || clientSecret == null) {
      throw StateError('Configure SPOTIFY_CLIENT_ID e SPOTIFY_CLIENT_SECRET no arquivo .env');
    }

    final credentials = spotify.SpotifyApiCredentials(clientId, clientSecret);
    final spotifyApi = spotify.SpotifyApi(credentials);
    final track = await spotifyApi.tracks.get(trackId);

    final artistName = track.artists?.firstOrNull?.name ?? 'artista desconhecido';
    final albumName = track.album?.name ?? 'álbum desconhecido';
    final artworkUrl = track.album?.images?.isNotEmpty == true ? track.album!.images!.first.url : null;

    return TrackMetadata(
      title: track.name ?? 'faixa sem título',
      artist: artistName,
      album: albumName,
      durationMs: track.durationMs ?? track.duration?.inMilliseconds ?? 0,
      artworkUrl: artworkUrl,
    );
  }

  Future<Video> _findYoutubeVideo(String query) async {
    final results = await _youtube.search.search(query);
    final video = results.firstWhereOrNull((video) => video.duration != null) ?? results.firstOrNull;
    if (video == null) {
      throw StateError('Nenhum vídeo encontrado para "$query"');
    }
    return video;
  }

  bool _isYoutubeUrl(String url) {
    return VideoId.parseVideoId(url) != null || url.contains('youtube.com') || url.contains('youtu.be');
  }

  bool _isSpotifyUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host != 'open.spotify.com') return false;
    final segments = List<String>.from(uri.pathSegments.where((segment) => segment.isNotEmpty));
    if (segments.isEmpty) return false;
    if (segments.first.startsWith('intl-')) {
      segments.removeAt(0);
    }
    return segments.isNotEmpty && segments.first == 'track';
  }

  String? _extractSpotifyTrackId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host != 'open.spotify.com') return null;
    final segments = List<String>.from(uri.pathSegments.where((segment) => segment.isNotEmpty));
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

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _youtube.close();
  }
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
