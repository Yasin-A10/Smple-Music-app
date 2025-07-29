part of 'playlist_bloc.dart';

@immutable
sealed class PlaylistEvent {}

final class LoadPlaylist extends PlaylistEvent {}