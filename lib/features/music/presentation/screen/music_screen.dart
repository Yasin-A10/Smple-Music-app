import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/widgets/my_drawer.dart';
import '../bloc/audio_player_bloc.dart';
import '../bloc/audio_player_event.dart';
import '../bloc/audio_player_state.dart';
import '../../domain/entities/song.dart';
import 'package:go_router/go_router.dart';

class AudioPlayerScreen extends StatefulWidget {
  final Song initialSong;
  const AudioPlayerScreen({super.key, required this.initialSong});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  bool _didPlay = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // فقط یکبار هنگام نمایش صفحه، موزیک انتخابی را پخش کن
    if (!_didPlay) {
      context.read<AudioPlayerBloc>().add(PlaySongEvent(widget.initialSong));
      _didPlay = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text(
          'M U S I C',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => context.go('/playlist'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            final playlist = state.playlist;
            if (playlist.isEmpty) {
              return const Center(
                child: Text('No music available for playback'),
              );
            }
            final song = playlist[state.currentIndex];
            final position = state.position;
            final total = state.total;

            String formatTime(Duration d) {
              final minutes = d.inMinutes
                  .remainder(60)
                  .toString()
                  .padLeft(2, '0');
              final seconds = d.inSeconds
                  .remainder(60)
                  .toString()
                  .padLeft(2, '0');
              return '$minutes:$seconds';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                if (song.coverImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      song.coverImage!,
                      width: 270,
                      height: 270,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Text(
                  song.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Slider(
                        min: 0,
                        max: total.inSeconds > 0
                            ? total.inSeconds.toDouble()
                            : 1,
                        value: position.inSeconds
                            .clamp(0, total.inSeconds)
                            .toDouble(),
                        onChanged: (value) {
                          final newPos = Duration(seconds: value.toInt());
                          context.read<AudioPlayerBloc>().add(
                            SeekEvent(newPos),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(position)),
                            Text(formatTime(total)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 36,
                      onPressed: () =>
                          context.read<AudioPlayerBloc>().add(PreviousEvent()),
                      icon: const Icon(Icons.skip_previous),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      iconSize: 64,
                      onPressed: () => context.read<AudioPlayerBloc>().add(
                        PlayPauseToggleEvent(),
                      ),
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      iconSize: 36,
                      onPressed: () =>
                          context.read<AudioPlayerBloc>().add(NextEvent()),
                      icon: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}
