import 'package:flutter/material.dart';
import 'package:w8/data/repositories/artists/artist_repository.dart';
import 'package:w8/model/artists/artist.dart';
import 'package:w8/model/songs/song_artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      //fetch both
      final results = await Future.wait([
        songRepository.fetchSongs(),
        artistRepository.fetchArtists(),
      ]);
      
      final songs = results[0] as List<Song>;
      final artists = results[1] as List<Artist>;

      //build map to lookup artist with artistID
      final artistMap = {for (var a in artists) a.id: a};

      // pair song with artist
      final joined = songs
          .where((s) => artistMap.containsKey(s.artistId))
          .map((s) => SongArtist(song: s, artist: artistMap[s.artistId]!))
          .toList();

      songsValue = AsyncValue.success(joined);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
