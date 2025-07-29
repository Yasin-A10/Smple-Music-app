import 'package:flutter/services.dart';
import 'package:music_app/features/music/data/models/song_model.dart';
import 'dart:convert';

/// Local source for fetching the list of songs from a JSON file in assets
class LocalSongsSource {
  Future<List<SongModel>> fetchSongs() async {
    // Assuming the file assets/audio/songs.json contains the list of songs
    final jsonString = await rootBundle.loadString('assets/audio/songs.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((e) => SongModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
