import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_page.dart';
import '../features/library/library_page.dart';
import '../features/player/now_playing_page.dart';
import '../features/playlists/playlist_detail_page.dart';
import '../features/playlists/playlists_page.dart';
import '../features/settings/settings_page.dart';
import '../services/sync/sync_service.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final syncReady = ValueNotifier(false);
  ref.listen(syncReadyProvider, (_, next) => syncReady.value = next);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    refreshListenable: syncReady,
    redirect: (context, state) {
      final authenticated = ref.read(syncServiceProvider).isAuthenticated;
      if (!authenticated && state.location != '/auth') {
        return '/auth';
      }
      if (authenticated && state.location == '/auth') {
        return '/library';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => SonettoShell(child: child),
        routes: [
          GoRoute(
            path: '/library',
            builder: (context, state) => const LibraryPage(),
          ),
          GoRoute(
            path: '/playlists',
            builder: (context, state) => const PlaylistsPage(),
            routes: [
              GoRoute(
                path: ':playlistId',
                builder: (context, state) {
                  final playlistId = state.pathParameters['playlistId']!;
                  return PlaylistDetailPage(playlistId: playlistId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/now-playing',
            builder: (context, state) => const NowPlayingPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
});

class SonettoShell extends StatelessWidget {
  const SonettoShell({required this.child, super.key});

  final Widget child;

  int _selectedIndex(String location) {
    return switch (location) {
      final loc when loc.startsWith('/library') => 0,
      final loc when loc.startsWith('/playlists') => 1,
      final loc when loc.startsWith('/now-playing') => 2,
      final loc when loc.startsWith('/settings') => 3,
      _ => 0,
    };
  }

  List<NavigationDestination> get destinations => const [
        NavigationDestination(icon: Icon(Icons.library_music), label: 'biblioteca'),
        NavigationDestination(icon: Icon(Icons.queue_music), label: 'playlists'),
        NavigationDestination(icon: Icon(Icons.play_circle), label: 'tocando'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'configurações'),
      ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _selectedIndex(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: destinations,
        onDestinationSelected: (value) {
          switch (value) {
            case 0:
              context.go('/library');
            case 1:
              context.go('/playlists');
            case 2:
              context.go('/now-playing');
            case 3:
              context.go('/settings');
          }
        },
      ),
    );
  }
}
