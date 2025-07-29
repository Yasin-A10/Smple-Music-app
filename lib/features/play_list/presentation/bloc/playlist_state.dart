part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistState {}

class PlaylistInitial extends PlaylistState {}
class PlaylistLoading extends PlaylistState {}
class PlaylistLoaded extends PlaylistState {
  final List<Song> songs;
  PlaylistLoaded(this.songs);
}
class PlaylistError extends PlaylistState {
  final String message;
  PlaylistError(this.message);
}