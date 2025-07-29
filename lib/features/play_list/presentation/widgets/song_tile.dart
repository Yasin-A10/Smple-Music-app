import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/features/music/domain/entities/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: song.coverImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(song.coverImage!),
              ),
            )
          : const Icon(Icons.music_note),
      title: Text(song.title),
      subtitle: Text(song.artist),
      onTap: () {
        context.push('/song/${song.id}', extra: song);
      },
    );
  }
}
