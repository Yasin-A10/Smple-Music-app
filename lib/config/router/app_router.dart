import 'package:go_router/go_router.dart';
import 'package:music_app/config/router/route_path.dart';
import 'package:music_app/features/music/domain/entities/song.dart';
import 'package:music_app/features/play_list/presentation/screen/play_list_screen.dart';
import 'package:music_app/features/setting/presentation/screen/setting_screen.dart';
import 'package:music_app/features/music/presentation/screen/music_screen.dart';
import 'package:music_app/features/not_found_screen.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.playlist,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: RoutePaths.setting,
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: RoutePaths.playlist,
      builder: (context, state) => const PlaylistScreen(),
    ),
    GoRoute(
      path: RoutePaths.music,
      builder: (context, state) {
        final song = state.extra as Song;
        return AudioPlayerScreen(initialSong: song);
      },
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
