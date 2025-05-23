import 'package:flutter/material.dart';
import 'package:tik_tak_toe/pages/game_page.dart';
import 'package:tik_tak_toe/pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      routes:{
        '/game':(context)=> const GamePage(),
      }
    );
  }
}