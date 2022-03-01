import 'package:My_Flutter_Projects/animated%20skin/skin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedSkinMain extends StatefulWidget {
  final String appBarTitle;

  const AnimatedSkinMain({required this.appBarTitle});

  @override
  _AnimatedSkinMainState createState() => _AnimatedSkinMainState();
}

class _AnimatedSkinMainState extends State<AnimatedSkinMain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late SkinModel _current = skinsList.first;
  late SkinModel _past = skinsList.last;
  void _onSkinSelected(SkinModel skin) {
    setState(() {
      _current = skin;
      _controller.forward(from: 0.0).whenComplete(() {
        setState(() {
          _past = _current;
        });
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      upperBound: 2.5,
      duration: Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.appBarTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    _current.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return ClipPath(
                        clipper: SkinClipper(
                          percent: _controller.value,
                          skin: _current,
                        ),
                        child: Image.asset(
                          _past.image,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  _current.name,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: skinsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return SkinButton(
                        onTap: () {
                          _onSkinSelected(skinsList[index]);
                        },
                        selected: _current.color == skinsList[index].color,
                        skinItems: skinsList[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkinClipper extends CustomClipper<Path> {
  final double percent;
  final SkinModel skin;
  SkinClipper({required this.skin, required this.percent});
  @override
  getClip(Size size) {
    final path = Path();
    Offset? center;
    if (skin.center == Alignment.center) {
      center = Offset(size.width / 2, size.height / 2);
    } else if (skin.center == Alignment.centerRight) {
      center = Offset(size.width, size.height / 2);
    } else if (skin.center == Alignment.centerRight) {
      center = Offset(size.width, size.height / 2);
    } else if (skin.center == Alignment.topCenter) {
      center = Offset(size.width, 0);
    } else if (skin.center == Alignment.bottomCenter) {
      center = Offset(size.width / 2, size.height);
    } else if (skin.center == Alignment.centerLeft) {
      center = Offset(0, size.height / 2);
    } else if (skin.center == Alignment.topRight) {
      center = Offset(0, size.height);
    } else {
      center = Offset(size.width / 2, size.height / 2);
    }
    path.addOval(
      Rect.fromCenter(
        center: center,
        width: size.width * percent,
        height: size.height * percent,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class SkinButton extends StatelessWidget {
  final SkinModel skinItems;
  final VoidCallback onTap;
  final bool selected;
  const SkinButton(
      {required this.skinItems, required this.onTap, required this.selected});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 48,
        vertical: 16,
      ),
      child: InkWell(
        onTap: onTap,
        radius: 25,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: selected ? 7 : 1,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: skinItems.color,
            ),
          ),
        ),
      ),
    );
  }
}
