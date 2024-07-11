// import 'package:chat_app/pages/chat.dart';
import 'package:math_fire/pages/home_page.dart';
import 'package:math_fire/pages/login.dart';
import 'package:math_fire/pages/menu.dart';
import 'package:math_fire/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:math_fire/pages/chatterScreen.dart';
import 'package:math_fire/pages/solution_page.dart';
import 'pages/splash.dart';

void main() => runApp(ChatterApp());

class ChatterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      
      theme: ThemeData(textTheme: TextTheme(body1: TextStyle(fontFamily: 'Poppins'),),),
      // home: ChatterHome(),
      initialRoute: '/',
      routes: {
        '/':(context)=>ChatterHome(),
        '/login':(context)=>ChatterLogin(),
        '/signup':(context)=>ChatterSignUp(),
        '/chat':(context)=>ChatterScreen(),
        // '/chats':(context)=>ChatterScreen(),
        '/menu':(context)=> MenuPage(),
        '/home':(context)=> HomePage(),
        '/solution':(context)=> SolutionPage(),
      },
    );
  }
}

