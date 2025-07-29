import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/features/music/domain/entities/song.dart';
import 'package:music_app/features/play_list/domain/usecase/get_all_songs.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final GetAllSongs getAllSongs;
  PlaylistBloc(this.getAllSongs) : super(PlaylistInitial()) {
    on<LoadPlaylist>(_onLoadPlaylist);
  }

  Future<void> _onLoadPlaylist(
    LoadPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistLoading());
    try {
      final songs = await getAllSongs();
      emit(PlaylistLoaded(songs));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }
}
