import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationBottomNavbar extends StatefulWidget {
  final String appBarTitle;

  const AnimationBottomNavbar({required this.appBarTitle});
  @override
  _AnimationBottomNavbarState createState() => _AnimationBottomNavbarState();
}

class _AnimationBottomNavbarState extends State<AnimationBottomNavbar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.appBarTitle),
      ),
      body: IndexedStack(
        children: [
          Container(
            color: Colors.grey,
          ),
          Container(
            color: Colors.deepOrange,
          ),
          Container(
            color: Colors.lightGreenAccent,
          ),
          Container(
            color: Colors.pink,
          ),
          Container(
            color: Colors.red,
          ),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BounceTabBar(
        backgroundColor: Theme.of(context).primaryColor,
        movement: 100.0,
        item: [
          Icon(
            Icons.airplanemode_active,
            color: Colors.white,
          ),
          Icon(
            Icons.upload_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.style,
            color: Colors.white,
          ),
          Icon(
            Icons.account_balance_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.place,
            color: Colors.white,
          ),
        ],
        onTapChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        initialIndex: 2,
      ),
    );
  }
}

class BounceTabBar extends StatefulWidget {
  final Color backgroundColor;
  final List<Widget> item;
  final ValueChanged<int> onTapChanged;
  final initialIndex;
  final double movement;
  const BounceTabBar({
    this.backgroundColor = Colors.red,
    required this.item,
    required this.onTapChanged,
    this.initialIndex = 0,
    this.movement = 100.0,
  });

  @override
  _BounceTabBarState createState() => _BounceTabBarState();
}

class _BounceTabBarState extends State<BounceTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationTabBarIn;
  late Animation _animationTabBarOut;
  late Animation _animationCircle;
  late Animation _animationFlyIn;
  late Animation _animationFlyOut;
  late int _currentIndex;
  @override
  void initState() {
    _currentIndex = widget.initialIndex ?? 0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animationTabBarIn = CurveTween(
      curve: Interval(
        0.1,
        0.6,
        curve: Curves.decelerate,
      ),
    ).animate(_controller);
    _animationTabBarOut = CurveTween(
      curve: Interval(
        0.6,
        1.0,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);
    _animationCircle = CurveTween(
      curve: Interval(
        0.0,
        0.5,
      ),
    ).animate(_controller);
    _animationFlyIn = CurveTween(
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.decelerate,
      ),
    ).animate(_controller);
    _animationFlyOut = CurveTween(
      curve: Interval(
        0.55,
        1.0,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);
    _controller.forward(from: 0.9);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double currentWidth = width;
    double currentFly = 0.0;
    final movement = widget.movement;
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              currentWidth = width -
                  (movement * _animationTabBarIn.value) +
                  (movement * _animationTabBarOut.value);
              currentFly = -movement * _animationFlyIn.value +
                  (movement - kBottomNavigationBarHeight / 4) *
                      _animationFlyOut.value;
              return Center(
                child: Container(
                  width: currentWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                    color: widget.backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      widget.item.length,
                      (index) {
                        final child = widget.item[index];
                        final innerWidget = CircleAvatar(
                          radius: 30,
                          backgroundColor: widget.backgroundColor,
                          child: child,
                        );
                        if (index == _currentIndex) {
                          return Expanded(
                            child: CustomPaint(
                              foregroundPainter:
                                  CirclePainter(_animationCircle.value),
                              child: Transform.translate(
                                offset: Offset(0.0, currentFly),
                                child: innerWidget,
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                widget.onTapChanged(index);
                                setState(() {
                                  _currentIndex = index;
                                });
                                _controller.forward(from: 0.0);
                              },
                              child: innerWidget,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  CirclePainter(this.progress);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 20.0;
    final currentRadius = radius * progress;
    final strokeWidth = 10.0;
    final currentStrokeWidth =
        progress == 0 ? 0.0 : strokeWidth * (1 - progress);

    if (progress < 1.0) {
      canvas.drawCircle(
        center,
        currentRadius,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentStrokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
