import 'package:flutter/material.dart';
import 'package:ist_study/screens/main/main_screen.dart';
import 'package:ist_study/style/colors.dart';
import 'package:ist_study/style/theme.dart';
import 'package:ist_study/style/theme_dark.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: new Scaffold(
        body: MainScreen(),
        backgroundColor: softBlue,
      ),
    );
  }
}
