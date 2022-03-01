import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'android messanger/android_messanger_main.dart';
import 'animated skin/animated_skin_main.dart';
import 'animation bottom navbar/animation_bottom_navbar.dart';
import 'book consept/book_consept_main.dart';
import 'draggable scrollable sheet/draggable_scrollable_sheet.dart';
import 'expandable navbar/expandable_bar_main.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Portfolio',
      theme: ThemeData(
        fontFamily: 'BroshkLime',
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.transparent,
        bottomAppBarColor: Colors.transparent,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Projects'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavigatorButton(
                widget: ExpandableNavBarHomeScreen(
                  title: 'Expandable Nav Bar',
                ),
                title: 'Expandable Nav Bar',
              ),
              NavigatorButton(
                widget: AndroidMessangerMainScreen(
                  title: ' Android Messanger',
                ),
                title: ' Android Messanger',
              ),
              NavigatorButton(
                widget: DraggableScrollableSheetMain(
                  appbarTitle: 'Draggable Scrollable Sheet',
                ),
                title: 'Draggable Scrollable Sheet',
              ),
              NavigatorButton(
                widget: BookConceptMain(
                  appbarTitle: 'Book Concept',
                ),
                title: 'Book Concept',
              ),
              NavigatorButton(
                widget: AnimationBottomNavbar(
                  appBarTitle: 'Animation Bottom Navbar',
                ),
                title: 'Animation Bottom Navbar',
              ),
              NavigatorButton(
                widget: AnimatedSkinMain(
                  appBarTitle: 'Animated Skin',
                ),
                title: 'Animated Skin',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final Widget? widget;
  final String? title;

  const NavigatorButton({
    required this.widget,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return widget!;
          }));
        },
        child: Text(
          title!,
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
      ),
    );
  }
}
