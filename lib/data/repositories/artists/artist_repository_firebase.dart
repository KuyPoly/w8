import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:w8/model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri baseUri = Uri.https(
    'week-8-practice-85762-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri artistsUri = baseUri.replace(path: "/artists.json");

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of artists
      Map<String, dynamic> artistJson = json.decode(response.body);
      final List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String id = iterable.key;
        Map<String, dynamic> data = iterable.value;
        result.add(ArtistDto.fromJson(id, data));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
