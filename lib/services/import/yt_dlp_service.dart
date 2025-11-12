import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;

final ytDlpServiceProvider = Provider<YtDlpService>((ref) {
  final binary = dotenv.env['YT_DLP_PATH'];
  return YtDlpService(binaryPath: binary);
});

class YtDlpService {
  YtDlpService({String? binaryPath})
      : _binary = (binaryPath?.trim().isNotEmpty ?? false)
            ? binaryPath!.trim()
            : _defaultBinaryName();

  final String _binary;

  Future<YtDlpVideo> getVideo(String url) {
    return _runForVideo(url);
  }

  Future<YtDlpVideo> searchFirst(String query) {
    return _runForVideo('ytsearch1:$query');
  }

  Future<YtDlpDownloadResult> downloadBestAudio(String url) async {
    _ensurePlatformSupported();
    final downloadDir =
        await Directory.systemTemp.createTemp('sonetto-yt-dlp-');
    final outputTemplate = p.join(downloadDir.path, 'source.%(ext)s');
    final args = [
      '--ignore-config',
      '--no-progress',
      '--no-call-home',
      '--no-playlist',
      '--newline',
      '-f',
      'bestaudio/best',
      '-o',
      outputTemplate,
      '--',
      url,
    ];

    try {
      await _run(args, workingDirectory: downloadDir.path);

      final downloaded = downloadDir.listSync().whereType<File>().where((file) {
        final name = p.basename(file.path);
        if (!name.startsWith('source.')) return false;
        if (name.endsWith('.info.json') ||
            name.endsWith('.description') ||
            name.endsWith('.part')) {
          return false;
        }
        return true;
      }).toList();

      if (downloaded.isEmpty) {
        throw const YtDlpException('yt-dlp não retornou arquivo de áudio');
      }

      downloaded.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      return YtDlpDownloadResult(
          file: downloaded.first, directory: downloadDir);
    } catch (error) {
      if (await downloadDir.exists()) {
        await downloadDir.delete(recursive: true);
      }
      rethrow;
    }
  }

  Future<YtDlpVideo> _runForVideo(String target) async {
    _ensurePlatformSupported();
    final args = [
      '--ignore-config',
      '--no-call-home',
      '--no-warnings',
      '--no-progress',
      '--skip-download',
      '--dump-json',
      '--',
      target,
    ];
    final result = await _run(args);
    return YtDlpVideo.fromJson(_decodeJson(result.stdout));
  }

  Future<_CommandResult> _run(List<String> args,
      {String? workingDirectory}) async {
    try {
      final process = await Process.run(
        _binary,
        args,
        workingDirectory: workingDirectory,
      );
      if (process.exitCode != 0) {
        throw YtDlpException(
          'yt-dlp retornou código ${process.exitCode}',
          stdout: process.stdout?.toString(),
          stderr: process.stderr?.toString(),
        );
      }
      return _CommandResult(
        stdout: process.stdout?.toString() ?? '',
        stderr: process.stderr?.toString() ?? '',
      );
    } on ProcessException catch (error) {
      throw YtDlpException(
        'Falha ao executar $_binary: ${error.message}. '
        'Garanta que yt-dlp esteja instalado e acessível no PATH ou configure YT_DLP_PATH no .env.',
      );
    }
  }

  void _ensurePlatformSupported() {
    if (Platform.isAndroid || Platform.isIOS) {
      throw const YtDlpException(
          'yt-dlp só é suportado em plataformas desktop neste projeto');
    }
  }

  static Map<String, dynamic> _decodeJson(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      throw const YtDlpException('yt-dlp não retornou dados JSON');
    }
    return jsonDecode(trimmed) as Map<String, dynamic>;
  }

  static String _defaultBinaryName() {
    if (Platform.isWindows) {
      return 'yt-dlp.exe';
    }
    return 'yt-dlp';
  }
}

class YtDlpVideo {
  YtDlpVideo({
    required this.id,
    required this.title,
    required this.channel,
    required this.url,
    this.duration,
    this.thumbnailUrl,
  });

  factory YtDlpVideo.fromJson(Map<String, dynamic> json) {
    final durationSeconds = json['duration'];
    Duration? duration;
    if (durationSeconds is num) {
      duration = Duration(seconds: durationSeconds.round());
    }

    final thumbnails = json['thumbnails'];
    String? thumb;
    if (json['thumbnail'] is String) {
      thumb = json['thumbnail'] as String;
    } else if (thumbnails is List && thumbnails.isNotEmpty) {
      final last = thumbnails.last;
      if (last is Map && last['url'] is String) {
        thumb = last['url'] as String;
      }
    }

    return YtDlpVideo(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Vídeo sem título',
      channel: json['artist']?.toString() ??
          json['uploader']?.toString() ??
          json['channel']?.toString() ??
          'Autor desconhecido',
      url: json['webpage_url']?.toString() ??
          json['original_url']?.toString() ??
          (json['id'] != null
              ? 'https://www.youtube.com/watch?v=${json['id']}'
              : ''),
      duration: duration,
      thumbnailUrl: thumb,
    );
  }

  final String id;
  final String title;
  final String channel;
  final String url;
  final Duration? duration;
  final String? thumbnailUrl;
}

class YtDlpDownloadResult {
  const YtDlpDownloadResult({required this.file, required this.directory});

  final File file;
  final Directory directory;

  Future<void> cleanup() async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}

class YtDlpException implements Exception {
  const YtDlpException(this.message, {this.stdout, this.stderr});

  final String message;
  final String? stdout;
  final String? stderr;

  @override
  String toString() {
    final buffer = StringBuffer('YtDlpException: $message');
    if (stderr != null && stderr!.trim().isNotEmpty) {
      buffer.write('\nstderr: ${stderr!.trim()}');
    }
    if (stdout != null && stdout!.trim().isNotEmpty) {
      buffer.write('\nstdout: ${stdout!.trim()}');
    }
    return buffer.toString();
  }
}

class _CommandResult {
  _CommandResult({required this.stdout, required this.stderr});

  final String stdout;
  final String stderr;
}
