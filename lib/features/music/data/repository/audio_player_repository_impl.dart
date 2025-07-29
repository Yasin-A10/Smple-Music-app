import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/features/music/domain/repository/audio_player_repository.dart';
import 'package:music_app/features/play_list/data/source/local_songs_source.dart';
import '../../domain/entities/song.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final AudioPlayer _player;
  final LocalSongsSource _source;
  List<Song> _playlist = [];
  int _currentIndex = 0;

  AudioPlayerRepositoryImpl({
    required AudioPlayer player,
    required LocalSongsSource source,
  }) : _player = player,
       _source = source;

  @override
  Future<List<Song>> getPlaylist() async {
    final models = await _source.fetchSongs();
    _playlist = models;
    return _playlist;
  }

  @override
  Future<void> play(String path) async {
    await _player.play(AssetSource(path));
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> resume() async {
    await _player.resume();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future<void> next() async {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
      await play(_playlist[_currentIndex].assetPath);
    }
  }

  @override
  Future<void> previous() async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await play(_playlist[_currentIndex].assetPath);
    }
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Stream<Duration> getPositionStream() => _player.onPositionChanged;

  @override
  Future<Duration?> getDuration() => _player.getDuration();
}
