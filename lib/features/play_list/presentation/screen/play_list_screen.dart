import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/widgets/my_drawer.dart';
import 'package:music_app/features/play_list/presentation/bloc/playlist_bloc.dart';
import 'package:music_app/features/play_list/presentation/widgets/song_tile.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlaylistBloc>().add(LoadPlaylist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PLAY LIST', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            if (state is PlaylistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlaylistLoaded) {
              return ListView.separated(
                itemCount: state.songs.length,
                itemBuilder: (context, index) {
                  return SongTile(song: state.songs[index]);
                },
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              );
            } else if (state is PlaylistError) {
              return Center(child: Text('خطا: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
