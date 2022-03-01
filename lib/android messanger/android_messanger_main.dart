import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AndroidMessangerMainScreen extends StatefulWidget {
  final String? title;

  const AndroidMessangerMainScreen({this.title});
  @override
  _AndroidMessangerMainScreenState createState() =>
      _AndroidMessangerMainScreenState();
}

class _AndroidMessangerMainScreenState
    extends State<AndroidMessangerMainScreen> {
  ScrollController scrollController = ScrollController();
  void _onScrollDirection() {
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        expanded) {
      setState(() {
        expanded = false;
      });
    } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !expanded) {
      setState(() {
        expanded = true;
      });
    }
  }

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: Colors.black38,
                ),
                child: TextFormField(
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: -6,
                    ),
                    hintText: ' Search Conversations',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (details) {
                    _onScrollDirection();
                    return true;
                  },
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: 77,
                    itemBuilder: (context, index) {
                      return AndroidMessageListItem(
                        color: index > 17
                            ? Colors.primaries[index % Colors.primaries.length]
                            : Colors.accents[index % Colors.accents.length],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: AndroidMessangerFAB(
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
          expanded: expanded,
        ),
      ),
    );
  }
}

class AndroidMessageListItem extends StatelessWidget {
  final Color color;

  const AndroidMessageListItem({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          Icons.person,
          color: Colors.black,
        ),
      ),
      title: Text('+998 33 287 02 24'),
      subtitle: Text('How Do You Do ? Whats Up '),
      trailing: Text('4 hours'),
    );
  }
}

class AndroidMessangerFAB extends StatefulWidget {
  final bool expanded;
  final VoidCallback? onTap;
  const AndroidMessangerFAB({this.expanded = false, required this.onTap});

  @override
  _AndroidMessangerFABState createState() => _AndroidMessangerFABState();
}

const Duration _animationDuration = Duration(milliseconds: 250);
const _minSize = 50.0;
const _maxSize = 150.0;
const _iconSize = 24.0;

class _AndroidMessangerFABState extends State<AndroidMessangerFAB> {
  @override
  Widget build(BuildContext context) {
    final position = _minSize / 2 - _iconSize / 2;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: _animationDuration,
        height: _minSize,
        width: widget.expanded ? _maxSize : _minSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            _minSize,
          ),
          color: Colors.blue[800],
        ),
        child: Stack(
          children: [
            Positioned(
              left: position,
              top: position,
              child: Icon(
                Icons.message,
                size: _iconSize,
              ),
            ),
            Positioned(
                left: position + 1.6 * _iconSize,
                // right: position,
                top: position,
                child: Text(
                  'Start Chat',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
