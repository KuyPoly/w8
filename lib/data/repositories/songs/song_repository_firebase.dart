import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.https(
    'week-8-practice-85762-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri songsUri = baseUri.replace(path: "/songs.json");
  static final Uri artistsUri = baseUri.replace(path: "/artists.json");

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);
      final List<Song> result = [];

      for (var iterable in songJson.entries) {
        String id = iterable.key;
        Map<String, dynamic> data = iterable.value;
        result.add(SongDto.fromJson(id, data));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
