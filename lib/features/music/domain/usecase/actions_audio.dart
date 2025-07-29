import 'package:music_app/features/music/domain/repository/audio_player_repository.dart';

class PlayAudio {
  final AudioPlayerRepository repo;
  PlayAudio(this.repo);
  Future<void> call(String path) => repo.play(path);
}

class PauseAudio {
  final AudioPlayerRepository repo;
  PauseAudio(this.repo);
  Future<void> call() => repo.pause();
}

class ResumeAudio {
  final AudioPlayerRepository repo;
  ResumeAudio(this.repo);
  Future<void> call() => repo.resume();
}

class NextAudio {
  final AudioPlayerRepository repo;
  NextAudio(this.repo);
  Future<void> call() => repo.next();
}

class PreviousAudio {
  final AudioPlayerRepository repo;
  PreviousAudio(this.repo);
  Future<void> call() => repo.previous();
}

class SeekAudio {
  final AudioPlayerRepository repo;
  SeekAudio(this.repo);
  Future<void> call(Duration position) => repo.seek(position);
}
