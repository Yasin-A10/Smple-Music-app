import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/music/domain/usecase/actions_audio.dart';
import 'package:music_app/features/music/domain/usecase/get_playlist.dart';
import 'audio_player_event.dart';
import 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final GetPlaylist getPlaylist;
  final PlayAudio playAudio;
  final PauseAudio pauseAudio;
  final ResumeAudio resumeAudio;
  final NextAudio nextAudio;
  final PreviousAudio previousAudio;
  final SeekAudio seekAudio;
  StreamSubscription<Duration>? _positionSub;

  AudioPlayerBloc({
    required this.getPlaylist,
    required this.playAudio,
    required this.pauseAudio,
    required this.resumeAudio,
    required this.nextAudio,
    required this.previousAudio,
    required this.seekAudio,
  }) : super(AudioPlayerState()) {
    on<LoadPlaylistEvent>(_onLoadPlaylist);
    on<PlayPauseToggleEvent>(_onPlayPause);
    on<NextEvent>(_onNext);
    on<PreviousEvent>(_onPrevious);
    on<PositionChangedEvent>(_onPositionChanged);
    on<SeekEvent>(_onSeek);
    on<PlaySongEvent>(_onPlaySong);
  }

  Future<void> _onLoadPlaylist(
    LoadPlaylistEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final list = await getPlaylist.call();
    if (list.isEmpty) {
      emit(
        state.copyWith(
          playlist: [],
          total: Duration.zero,
          position: Duration.zero,
          isPlaying: false,
        ),
      );
      return;
    }

    // Stop previous subscription
    _positionSub?.cancel();

    // Initialize playlist and play first track
    emit(state.copyWith(playlist: list, currentIndex: 0));
    await playAudio.call(list[0].assetPath);
    final total = await playAudio.repo.getDuration() ?? Duration.zero;
    emit(state.copyWith(total: total, isPlaying: true));

    // Subscribe to position changes
    _positionSub = playAudio.repo.getPositionStream().listen((pos) {
      add(PositionChangedEvent(pos));
    });
  }

  Future<void> _onPlayPause(
    PlayPauseToggleEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state.isPlaying) {
      await pauseAudio.call();
      emit(state.copyWith(isPlaying: false));
    } else {
      await resumeAudio.call();
      emit(state.copyWith(isPlaying: true));
    }
  }

  Future<void> _onNext(NextEvent event, Emitter<AudioPlayerState> emit) async {
    final nextIndex = state.currentIndex + 1;
    if (nextIndex < state.playlist.length) {
      _positionSub?.cancel();
      await nextAudio.call();
      emit(state.copyWith(currentIndex: nextIndex, position: Duration.zero));
      final total = await playAudio.repo.getDuration() ?? Duration.zero;
      emit(state.copyWith(total: total, isPlaying: true));

      _positionSub = playAudio.repo.getPositionStream().listen((pos) {
        add(PositionChangedEvent(pos));
      });
    }
  }

  Future<void> _onPrevious(
    PreviousEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final prevIndex = state.currentIndex - 1;
    if (prevIndex >= 0) {
      _positionSub?.cancel();
      await previousAudio.call();
      emit(state.copyWith(currentIndex: prevIndex, position: Duration.zero));
      final total = await playAudio.repo.getDuration() ?? Duration.zero;
      emit(state.copyWith(total: total, isPlaying: true));

      _positionSub = playAudio.repo.getPositionStream().listen((pos) {
        add(PositionChangedEvent(pos));
      });
    }
  }

  void _onPositionChanged(
    PositionChangedEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(state.copyWith(position: event.position));
  }

  Future<void> _onSeek(SeekEvent event, Emitter<AudioPlayerState> emit) async {
    await seekAudio.call(event.position);
    emit(state.copyWith(position: event.position));
  }

  Future<void> _onPlaySong(
    PlaySongEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    // اگر هنوز لیست لود نشده، ابتدا لود کن
    if (state.playlist.isEmpty) {
      final list = await getPlaylist.call();
      emit(state.copyWith(playlist: list));
    }
    // پیدا کردن اندیس موزیک انتخاب‌شده
    final idx = state.playlist.indexWhere((s) => s.id == event.song.id);
    if (idx < 0) return;

    // قطع اشتراک قبلی و پخش ترک جدید
    _positionSub?.cancel();
    await playAudio.call(event.song.assetPath);

    // تنظیم State
    final total = await playAudio.repo.getDuration() ?? Duration.zero;
    emit(
      state.copyWith(
        currentIndex: idx,
        total: total,
        position: Duration.zero,
        isPlaying: true,
      ),
    );

    // دوباره اشتراک تغییرات موقعیت
    _positionSub = playAudio.repo.getPositionStream().listen((pos) {
      add(PositionChangedEvent(pos));
    });
  }

  @override
  Future<void> close() {
    _positionSub?.cancel();
    return super.close();
  }
}
