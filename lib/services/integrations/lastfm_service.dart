import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/track.dart';

class LastFmService {
  LastFmService(this._dio);

  final Dio _dio;

  String? get _apiKey => dotenv.env['LASTFM_API_KEY'];
  String? get _apiSecret => dotenv.env['LASTFM_API_SECRET'];

  bool get isConfigured => _apiKey?.isNotEmpty == true && _apiSecret?.isNotEmpty == true;

  Future<String> createSession({
    required String username,
    required String password,
  }) async {
    final response = await _send({
      'method': 'auth.getMobileSession',
      'username': username,
      'password': password,
    });
    final session = response['session'] as Map<String, dynamic>?;
    final key = session?['key'] as String?;
    if (key == null || key.isEmpty) {
      throw StateError('Não foi possível obter a sessão do Last.fm');
    }
    return key;
  }

  Future<void> updateNowPlaying({
    required Track track,
    required String sessionKey,
  }) async {
    final params = {
      'method': 'track.updateNowPlaying',
      'artist': _sanitize(track.artist),
      'track': _sanitize(track.title),
      if (track.album.isNotEmpty) 'album': _sanitize(track.album),
      if (track.durationMs > 0) 'duration': '${track.durationMs ~/ 1000}',
      'sk': sessionKey,
    };
    await _send(params);
  }

  Future<void> scrobble({
    required Track track,
    required DateTime startedAt,
    required String sessionKey,
  }) async {
    final timestamp = startedAt.toUtc().millisecondsSinceEpoch ~/ 1000;
    final params = {
      'method': 'track.scrobble',
      'artist': _sanitize(track.artist),
      'track': _sanitize(track.title),
      if (track.album.isNotEmpty) 'album': _sanitize(track.album),
      if (track.durationMs > 0) 'duration': '${track.durationMs ~/ 1000}',
      'timestamp': '$timestamp',
      'sk': sessionKey,
    };
    await _send(params);
  }

  String _sanitize(String value) => value.trim().isEmpty ? 'desconhecido' : value.trim();

  Future<Map<String, dynamic>> _send(Map<String, String> params) async {
    if (!isConfigured) {
      throw StateError('LASTFM_API_KEY/LASTFM_API_SECRET não configurados no .env');
    }
    final requestParams = Map<String, String>.from(params)
      ..['api_key'] = _apiKey!;
    final signature = _signature(requestParams);
    requestParams['api_sig'] = signature;
    requestParams['format'] = 'json';
    final response = await _dio.post(
      '',
      data: requestParams,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw StateError('Resposta inválida do Last.fm');
    }
    if (data['error'] != null) {
      final message = data['message'] ?? 'Erro desconhecido';
      throw StateError('Last.fm: $message');
    }
    return data;
  }

  String _signature(Map<String, String> params) {
    final sortedKeys = params.keys.toList()..sort();
    final buffer = StringBuffer();
    for (final key in sortedKeys) {
      buffer.write(key);
      buffer.write(params[key]);
    }
    buffer.write(_apiSecret);
    final bytes = utf8.encode(buffer.toString());
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}

final lastFmServiceProvider = Provider<LastFmService>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://ws.audioscrobbler.com/2.0/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  return LastFmService(dio);
});
