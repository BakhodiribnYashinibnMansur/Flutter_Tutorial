import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SkinModel {
  final String name;
  final Color color;
  final String image;
  final Alignment center;
  SkinModel(
      {this.center = Alignment.center,
      required this.name,
      required this.color,
      required this.image});
}

final List<SkinModel> skinsList = [
  SkinModel(
    name: 'MacOS WallPaper',
    image: 'assets/image/wallpaper1.jpg',
    color: Colors.purple,
    center: Alignment.center,
  ),
  SkinModel(
    name: 'Space',
    image: 'assets/image/wallpaper2.jpg',
    color: Colors.black87,
    center: Alignment.centerRight,
  ),
  SkinModel(
      name: 'Abstract 1',
      image: 'assets/image/wallpaper3.jpg',
      color: Colors.yellow,
      center: Alignment.topCenter),
  SkinModel(
    name: 'Abstract 2',
    image: 'assets/image/wallpaper4.jpg',
    center: Alignment.bottomCenter,
    color: Colors.grey,
  ),
  SkinModel(
    name: 'Sword Art Online',
    image: 'assets/image/wallpaper5.jpg',
    color: Colors.deepPurple,
    center: Alignment.centerLeft,
  ),
  SkinModel(
    name: 'Superman',
    image: 'assets/image/wallpaper6.jpg',
    color: Colors.red[700]!,
    center: Alignment.topRight,
  ),
];
