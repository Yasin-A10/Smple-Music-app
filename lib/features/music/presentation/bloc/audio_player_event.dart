import 'package:flutter/foundation.dart';
import 'package:music_app/features/music/domain/entities/song.dart';

@immutable
sealed class AudioPlayerEvent {}

class LoadPlaylistEvent extends AudioPlayerEvent {}

class PlayPauseToggleEvent extends AudioPlayerEvent {}

class NextEvent extends AudioPlayerEvent {}

class PreviousEvent extends AudioPlayerEvent {}

class PositionChangedEvent extends AudioPlayerEvent {
  final Duration position;
  PositionChangedEvent(this.position);
}

class SeekEvent extends AudioPlayerEvent {
  final Duration position;
  SeekEvent(this.position);
}

class PlaySongEvent extends AudioPlayerEvent {
  final Song song;
  PlaySongEvent(this.song);
}
