import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/data/repositories/songs/song_repository.dart';
import 'package:w8/ui/screens/artist_detail.dart/view_model/artist_details_view_model.dart';
import 'package:w8/ui/screens/artist_detail.dart/widgets/artist_details_content.dart';
import '../../../data/repositories/artist/artist_repository.dart';
import '../../../model/artist/artist.dart';

class ArtistDetailScreen extends StatelessWidget {
  const ArtistDetailScreen({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistDetailViewModel(
        artistRepository: context.read<ArtistRepository>(),
        songRepository: context.read<SongRepository>(),
        artist: artist,
      ),
      child: ArtistDetailContent(),
    );
  }
}
