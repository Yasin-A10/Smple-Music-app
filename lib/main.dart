import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/config/router/app_router.dart';
import 'package:music_app/config/theme/app_theme.dart';
import 'package:music_app/core/di/injection.dart';
import 'package:music_app/features/music/presentation/bloc/audio_player_bloc.dart';
import 'package:music_app/features/music/presentation/bloc/audio_player_event.dart';
import 'package:music_app/features/play_list/presentation/bloc/playlist_bloc.dart';
import 'package:music_app/features/setting/presentation/bloc/setting_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependencies
  await init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingBloc>(create: (_) => sl<SettingBloc>()),
        BlocProvider<PlaylistBloc>(create: (_) => sl<PlaylistBloc>()),
        BlocProvider<AudioPlayerBloc>(
          create: (_) => sl<AudioPlayerBloc>()..add(LoadPlaylistEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MaterialApp.router(
            routerConfig: appRouter,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            locale: const Locale('en', 'US'),
          ),
        );
      },
    );
  }
}
