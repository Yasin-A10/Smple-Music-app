import 'package:music_app/features/music/domain/entities/song.dart';
import 'package:music_app/features/play_list/data/source/local_songs_source.dart';
import 'package:music_app/features/play_list/domain/repository/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final LocalSongsSource localSource;

  SongRepositoryImpl(this.localSource);

  @override
  Future<List<Song>> getAllSongs() async {
    return await localSource.fetchSongs();
  }
}
