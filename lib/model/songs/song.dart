class Song {
  final String id;
  final String title;
  final String artistId;
  final Duration duration;
  final Uri imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artistId,
    required this.duration,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Song(title: $title, artist: $artistId, duration: $duration)';
  }

  String get durationText {
    // Get total minutes
    final minutes = duration.inMinutes;
    // Get the remaining seconds after subtracting minutes
    final seconds = duration.inSeconds.remainder(60);
    // padLeft(2, '0') ensures that 5 seconds becomes "05"
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
