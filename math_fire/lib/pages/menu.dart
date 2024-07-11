import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:math_fire/pages/chatterScreen.dart';
import 'package:math_fire/pages/home_page.dart';
import 'package:math_fire/pages/solution_page.dart';
import 'package:math_fire/services/voice.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();
final List<Widget> viewContainer = [
    ChatterScreen(),
    HomePage(),
    SolutionPage(),
    MyApp(),  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: viewContainer[_page],
          bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.white,
          color: Colors.deepPurpleAccent,
          buttonBackgroundColor: Colors.deepPurpleAccent,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.chat, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.done, size: 30),
            Icon(Icons.music_note, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
);
  }
  }
