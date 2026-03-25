import 'package:w8/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();

  Future<Artist?> fetchArtistById(String id);
}
