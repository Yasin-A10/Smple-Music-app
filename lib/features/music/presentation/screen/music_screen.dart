import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/audio_player_bloc.dart';
import '../bloc/audio_player_event.dart';
import '../bloc/audio_player_state.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پخش موزیک'), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            final playlist = state.playlist;
            if (playlist.isEmpty) {
              return const Center(
                child: Text('هیچ موزیکی برای پخش وجود ندارد'),
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
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Text(
                  song.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  song.artist,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Slider(
                      //   min: 0,
                      //   max: total.inSeconds > 0
                      //       ? total.inSeconds.toDouble()
                      //       : 1,
                      //   value: position.inSeconds
                      //       .clamp(0, total.inSeconds)
                      //       .toDouble(),
                      //   onChanged: (value) {
                      //     // TODO: پیاده‌سازی seek اگر نیاز
                      //   },
                      // ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(position)),
                          Text(formatTime(total)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
