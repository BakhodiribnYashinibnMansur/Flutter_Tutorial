import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraggableScrollableSheetMain extends StatefulWidget {
  final String? appbarTitle;

  const DraggableScrollableSheetMain({Key? key, this.appbarTitle})
      : super(key: key);
  @override
  _DraggableScrollableSheetMainState createState() =>
      _DraggableScrollableSheetMainState();
}

class _DraggableScrollableSheetMainState
    extends State<DraggableScrollableSheetMain> {
  double _percent = 0.0;
  @override
  Widget build(BuildContext context) {
    final Size responsiveSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appbarTitle!),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              bottom: responsiveSize.height * 0.3,
              child: Image.asset(
                'assets/image/map.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
                bottom: responsiveSize.height * 0.3,
                child: Opacity(
                  opacity: _percent,
                  child: Container(
                    foregroundDecoration: BoxDecoration(color: Colors.black45),
                  ),
                )),
            Positioned(
              left: 20,
              top: 20,
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: 'menu',
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              right: 20,
              bottom: responsiveSize.height * 0.4,
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: 'location',
                child: Icon(
                  Icons.location_searching,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Positioned.fill(
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  setState(() {
                    _percent = notification.extent * 2 - 0.8;
                  });
                  return true;
                },
                child: DraggableScrollableSheet(
                    maxChildSize: 0.9,
                    minChildSize: 0.4,
                    builder: (BuildContext context, controller) {
                      return Material(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        elevation: 16,
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'It is good to see you ',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                ' Where are you going ? ',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.location_searching,
                                    color: Colors.purple,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 20),
                                  hintText: 'Search Destination',
                                  hintStyle: TextStyle(fontSize: 19),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 40),
                                    controller: controller,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 77,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.location_on_outlined,
                                        ),
                                        title: Text('Address ${index + 1}'),
                                        subtitle: Text('City ${index + 1}'),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              top: -170 * (1 - _percent),
              child: Opacity(
                opacity: _percent,
                child: SearchDestination(),
              ),
              left: 0,
              right: 0,
              // height: responsiveSize.height * .19,
            ),
            Positioned(
              child: Opacity(
                opacity: _percent,
                child: PickPlaceInMap(),
              ),
              bottom: -50 * (1 - _percent),
              left: 0,
              right: 0,
              // height: responsiveSize.height * .19,
            ),
          ],
        ),
      ),
    );
  }
}

class PickPlaceInMap extends StatelessWidget {
  const PickPlaceInMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[300],
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.place_sharp,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Pick in the map'),
          ],
        ),
      ),
    );
  }
}

class SearchDestination extends StatelessWidget {
  const SearchDestination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              BackButton(),
              Text(
                'Choose Destination',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          hintText: 'Avenue 24 NU 219',
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          hintText: 'Where are you going ?',
                          hintStyle: TextStyle(fontSize: 19),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
