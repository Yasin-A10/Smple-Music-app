import '../entities/song.dart';
// import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerRepository {
  Future<void> play(String path);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> next();
  Future<void> previous();
  Future<void> seek(Duration position);  
  Stream<Duration> getPositionStream();
  Future<Duration?> getDuration();
  Future<List<Song>> getPlaylist();
}
