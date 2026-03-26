import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.genre,
    required this.artistName,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final String genre;
  final String artistName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          subtitle: Row(
            children: [
              Text(song.durationText),
              const SizedBox(width: 10,),
              Text("$artistName - $genre"),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
