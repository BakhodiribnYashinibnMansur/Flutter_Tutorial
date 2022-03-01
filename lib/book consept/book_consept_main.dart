import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'book_model.dart';

class BookConceptMain extends StatefulWidget {
  final String? appbarTitle;

  const BookConceptMain({Key? key, required this.appbarTitle})
      : super(key: key);

  @override
  _BookConceptMainState createState() => _BookConceptMainState();
}

class _BookConceptMainState extends State<BookConceptMain> {
  final PageController? _controller = PageController();
  final ValueNotifier<double>? _notifierScroll = ValueNotifier(0.0);
  void _listener() {
    _notifierScroll!.value = _controller!.page!;
  }

  @override
  void initState() {
    _controller!.addListener(() {
      _listener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(() {
      _listener();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size responsiveSize = MediaQuery.of(context).size;
    final bookHeight = responsiveSize.height * 0.5;
    final bookWidth = responsiveSize.width * 0.7;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/image/wallpaper4.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 70,
            child: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text(
                widget.appbarTitle!,
              ),
              centerTitle: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.symmetric(vertical: 45),
            child: ValueListenableBuilder<double>(
              valueListenable: _notifierScroll!,
              builder: (context, value, _) {
                return PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    final book = bookList[index];
                    final percentage = index - value;
                    final rotation = percentage.clamp(0.0, 1.0);
                    final fixRotation = pow(rotation, 0.35);
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: bookHeight,
                                      width: bookWidth,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 10,
                                              offset: Offset(5.0, 5.0),
                                              spreadRadius: 20,
                                            ),
                                          ]),
                                    ),
                                    Transform(
                                      alignment: Alignment.centerLeft,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.002)
                                        ..rotateY(1.4 * fixRotation)
                                        ..translate(-rotation *
                                            responsiveSize.width *
                                            0.8)
                                        ..scale(
                                          (1 + 0.2 * rotation),
                                        ),
                                      child: Image.asset(
                                        book.bookImage,
                                        fit: BoxFit.cover,
                                        width: bookWidth,
                                        height: bookHeight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 90,
                              ),
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.white12,
                                    blurRadius: 20,
                                    offset: Offset(5.0, 5.0),
                                    spreadRadius: 20,
                                  ),
                                ]),
                                child: Opacity(
                                  opacity: 1 - rotation,
                                  child: Column(
                                    children: [
                                      Text(
                                        book.title,
                                        style: TextStyle(fontSize: 35),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "By ${book.author}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
