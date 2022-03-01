import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'music_model.dart';

const _cardColor = Color(0xff5f40fb);
const _maxHeight = 350.0;
const _minHeight = 70.0;

class ExpandableNavBarHomeScreen extends StatefulWidget {
  final String? title;

  const ExpandableNavBarHomeScreen({required this.title});

  @override
  _ExpandableNavBarHomeScreenState createState() =>
      _ExpandableNavBarHomeScreenState();
}

class _ExpandableNavBarHomeScreenState extends State<ExpandableNavBarHomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool? _expanded = false;
  double _currentHeight = _minHeight;
  Music? _currentMusic;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double menuWidth = size.width * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: ListView.builder(
              itemCount: musicList!.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding:
                  EdgeInsets.only(bottom: _minHeight + 25, left: 20, right: 20),
              itemBuilder: (context, index) {
                final music = musicList![index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentMusic = music;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          child: Image.asset(
                            music.musicImage!,
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        ),
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(music.singerImage!),
                                  maxRadius: 30,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  music.singerTitle!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                      ),
                                      Shadow(
                                        blurRadius: 16,
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  music.musicTitle!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                      ),
                                      Shadow(
                                        blurRadius: 16,
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedBuilder(
              animation: _controller!,
              builder: (context, snapshot) {
                final timeValue =
                    ElasticInOutCurve(0.7).transform(_controller!.value);
                return GestureDetector(
                  // onTap: () {
                  //   setState(() {
                  //     _expanded = !_expanded!;
                  //   });
                  //   if (_expanded!) {
                  //     _controller!.forward();
                  //   } else {
                  //     _controller!.reverse();
                  //   }
                  // },
                  onVerticalDragUpdate: _expanded!
                      ? (details) {
                          setState(() {
                            final newHeight = _currentHeight - details.delta.dy;
                            _controller!.value = _currentHeight / _maxHeight;
                            _currentHeight =
                                newHeight.clamp(_minHeight, _maxHeight);
                          });
                        }
                      : null,
                  onVerticalDragEnd: _expanded!
                      ? (details) {
                          if (_currentHeight < _maxHeight / 1.5) {
                            _controller!.reverse();
                            _expanded = false;
                          } else {
                            _expanded = true;
                            _controller!
                                .forward(from: _currentHeight / _maxHeight);
                            _currentHeight = _maxHeight;
                          }
                        }
                      : null,
                  child: Stack(
                    children: [
                      Positioned(
                        height:
                            lerpDouble(_minHeight, _currentHeight, timeValue),
                        left: lerpDouble(
                            size.width / 2 - menuWidth / 2, 0, timeValue),
                        width: lerpDouble(menuWidth, size.width, timeValue),
                        bottom: lerpDouble(40, 0, timeValue),
                        child: Container(
                          child: _expanded!
                              ? Opacity(
                                  opacity: _controller!.value,
                                  child: _buildExpandedContext(_currentMusic),
                                )
                              : _buildMenuContext(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                              bottom: Radius.circular(
                                  lerpDouble(20, 0, timeValue)!.toDouble()),
                            ),
                            color: Color.lerp(Colors.purple[700],
                                Colors.purple[400], timeValue),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildExpandedContext(Music? music) {
    return music != null
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.black,
                      height: 160,
                      width: 160,
                      child: Image.asset(music.musicImage!),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      music.singerTitle!,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      music.musicTitle!,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.shuffle),
                        Icon(Icons.pause),
                        Icon(Icons.playlist_add_outlined),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox();
  }

  Widget _buildMenuContext() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.my_library_music),
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded!;
              _currentHeight = _maxHeight;
              _controller!.forward(from: 0);
              Future.delayed(Duration(milliseconds: 300), () {
                if (_currentMusic == null) {
                  _controller!.reverse();
                  _expanded = false;
                }
              });
              Timer(
                Duration(milliseconds: 300),
                () {},
              );
            });
          },
          child: _currentMusic != null
              ? CircleAvatar(
                  backgroundImage: AssetImage(_currentMusic!.singerImage!),
                  maxRadius: 25,
                )
              : Icon(Icons.music_note_rounded),
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/image/wallpaper6.jpg'),
          maxRadius: 17,
        ),
      ],
    );
  }
}
