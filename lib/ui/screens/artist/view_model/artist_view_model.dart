import 'package:flutter/widgets.dart';
import 'package:w8/data/repositories/artists/artist_repository.dart';
import 'package:w8/model/artists/artist.dart';
import '../../../utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepo;

  AsyncValue<List<Artist>> artistValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepo}){
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    // 1- Loading state
    artistValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> songs = await artistRepo.fetchArtists();
      artistValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
