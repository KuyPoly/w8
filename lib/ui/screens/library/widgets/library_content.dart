import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/model/songs/song_artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<SongArtist>> asyncValue = mv.songsValue;

    Widget content;
    switch (asyncValue.state) {
      
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(child: Text('error = ${asyncValue.error!}', style: TextStyle(color: Colors.red),));

      case AsyncValueState.success:
        List<SongArtist> songArtist = asyncValue.data!;
        content = ListView.builder(
          itemCount: songArtist.length,
          itemBuilder: (context, index) {
            final item = songArtist[index]; 
            return SongTile(
              song: item.song, 
              artistName: item.artist.name, 
              genre: item.artist.genre, 
              isPlaying: mv.isSongPlaying(item.song),
              onTap: () => mv.start(item.song),
            );
          },
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
