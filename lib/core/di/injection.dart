// import 'package:get_it/get_it.dart';
// import 'package:music_app/features/play_list/data/repository/song_repository_impl.dart';
// import 'package:music_app/features/play_list/data/source/local_songs_source.dart';
// import 'package:music_app/features/play_list/domain/repository/song_repository.dart';
// import 'package:music_app/features/play_list/domain/usecase/get_all_songs.dart';
// import 'package:music_app/features/play_list/presentation/bloc/playlist_bloc.dart';
// import 'package:music_app/features/setting/presentation/bloc/setting_bloc.dart';

// final sl = GetIt.instance;

// /// Initialize dependencies
// Future<void> init() async {
//   // Data sources
//   sl.registerLazySingleton<LocalSongsSource>(() => LocalSongsSource());

//   // Repositories
//   sl.registerLazySingleton<SongRepository>(
//     () => SongRepositoryImpl(sl()),
//   );

//   // Use cases
//   sl.registerLazySingleton<GetAllSongs>(
//     () => GetAllSongs(sl()),
//   );

//   // Blocs/Cubits
//   sl.registerFactory<PlaylistBloc>(
//     () => PlaylistBloc(sl()),
//   );

//   sl.registerFactory<SettingBloc>(
//     () => SettingBloc(),
//   );
// }


import 'package:get_it/get_it.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/features/music/data/repository/audio_player_repository_impl.dart';
import 'package:music_app/features/music/domain/repository/audio_player_repository.dart';
import 'package:music_app/features/music/domain/usecase/actions_audio.dart';
import 'package:music_app/features/music/domain/usecase/get_playlist.dart';
import 'package:music_app/features/music/presentation/bloc/audio_player_bloc.dart';

import 'package:music_app/features/play_list/data/repository/song_repository_impl.dart';
import 'package:music_app/features/play_list/data/source/local_songs_source.dart';
import 'package:music_app/features/play_list/domain/repository/song_repository.dart';
import 'package:music_app/features/play_list/domain/usecase/get_all_songs.dart';
import 'package:music_app/features/play_list/presentation/bloc/playlist_bloc.dart';

import 'package:music_app/features/setting/presentation/bloc/setting_bloc.dart';

final sl = GetIt.instance;

/// Initialize dependencies
Future<void> init() async {
  // AudioPlayer instance
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  // Data sources
  sl.registerLazySingleton<LocalSongsSource>(() => LocalSongsSource());

  // Repositories
  sl.registerLazySingleton<SongRepository>(
    () => SongRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AudioPlayerRepository>(
    () => AudioPlayerRepositoryImpl(
      player: sl<AudioPlayer>(),
      source: sl<LocalSongsSource>(),
    ),
  );

  // Use cases (Playlist)
  sl.registerLazySingleton<GetAllSongs>(
    () => GetAllSongs(sl()),
  );
  // Use cases (Player)
  sl.registerLazySingleton<GetPlaylist>(
    () => GetPlaylist(sl()),
  );
  sl.registerLazySingleton<PlayAudio>(
    () => PlayAudio(sl()),
  );
  sl.registerLazySingleton<PauseAudio>(
    () => PauseAudio(sl()),
  );
  sl.registerLazySingleton<ResumeAudio>(
    () => ResumeAudio(sl()),
  );
  sl.registerLazySingleton<NextAudio>(
    () => NextAudio(sl()),
  );
  sl.registerLazySingleton<PreviousAudio>(
    () => PreviousAudio(sl()),
  );
  sl.registerLazySingleton<SeekAudio>(
    () => SeekAudio(sl()),
  );

  // Blocs/Cubits
  sl.registerFactory<PlaylistBloc>(
    () => PlaylistBloc(sl()),
  );
  sl.registerFactory<SettingBloc>(
    () => SettingBloc(),
  );
  sl.registerFactory<AudioPlayerBloc>(
    () => AudioPlayerBloc(
      getPlaylist: sl(),
      playAudio: sl(),
      pauseAudio: sl(),
      resumeAudio: sl(),
      nextAudio: sl(),
      previousAudio: sl(),
      seekAudio: sl(),
    ),
  );
}