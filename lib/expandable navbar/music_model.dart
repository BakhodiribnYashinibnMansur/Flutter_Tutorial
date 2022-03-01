class Music {
  final String? singerTitle;
  final String? musicTitle;
  final String? musicImage;
  final String? singerImage;

  Music({
    required this.singerTitle,
    required this.musicTitle,
    required this.musicImage,
    required this.singerImage,
  });
}

const imagePath = 'assets/image';
final List<Music>? musicList = [
  Music(
    singerTitle: 'Eminem',
    musicTitle: 'Loose Yourself',
    musicImage: '$imagePath/wallpaper1.jpg',
    singerImage: '$imagePath/wallpaper2.jpg',
  ),
  Music(
    singerTitle: 'Inna',
    musicTitle: 'Love You',
    musicImage: '$imagePath/wallpaper2.jpg',
    singerImage: '$imagePath/wallpaper3.jpg',
  ),
  Music(
    singerTitle: 'Alan Walker',
    musicTitle: 'Alone',
    musicImage: '$imagePath/wallpaper3.jpg',
    singerImage: '$imagePath/wallpaper4.jpg',
  ),
  Music(
    singerTitle: 'Shakira',
    musicTitle: 'Bad Boys',
    musicImage: '$imagePath/wallpaper4.jpg',
    singerImage: '$imagePath/wallpaper5.jpg',
  ),
  Music(
    singerTitle: 'Accent Group',
    musicTitle: 'Broken Heart',
    musicImage: '$imagePath/wallpaper5.jpg',
    singerImage: '$imagePath/wallpaper1.jpg',
  ),
];
