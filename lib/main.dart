import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/router.dart';
import 'core/env/env_config.dart';
import 'services/audio/playback_tracker.dart';
import 'services/sync/sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final env = EnvConfig.fromDotEnv(dotenv.env);
  final container = ProviderContainer(
    overrides: [envConfigProvider.overrideWithValue(env)],
  );
  await Supabase.initialize(url: env.supabaseUrl, anonKey: env.supabaseAnonKey);
  await container.read(syncServiceProvider).initialize();
  container.read(playbackTrackerProvider);
  runApp(UncontrolledProviderScope(container: container, child: const SonettoApp()));
}

class SonettoApp extends ConsumerWidget {
  const SonettoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final scheme = FlexColorScheme.light(scheme: FlexScheme.deepPurple).toTheme;
    final darkScheme = FlexColorScheme.dark(scheme: FlexScheme.deepPurple).toTheme;
    return MaterialApp.router(
      title: 'Sonetto',
      theme: scheme,
      darkTheme: darkScheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
