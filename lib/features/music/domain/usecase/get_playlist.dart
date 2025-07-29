import 'package:music_app/features/music/domain/repository/audio_player_repository.dart';
import '../entities/song.dart';

class GetPlaylist {
  final AudioPlayerRepository repo;
  GetPlaylist(this.repo);
  Future<List<Song>> call() => repo.getPlaylist();
}