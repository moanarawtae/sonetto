import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvConfig {
  const EnvConfig({required this.supabaseUrl, required this.supabaseAnonKey});

  final String supabaseUrl;
  final String supabaseAnonKey;

  factory EnvConfig.fromDotEnv(Map<String, String> env) {
    final url = env['SUPABASE_URL'];
    final key = env['SUPABASE_ANON_KEY'];
    if (url == null || url.isEmpty || key == null || key.isEmpty) {
      throw StateError('supabase env vars ausentes');
    }
    return EnvConfig(supabaseUrl: url, supabaseAnonKey: key);
  }
}

final envConfigProvider = Provider<EnvConfig>((ref) => throw UnimplementedError());
