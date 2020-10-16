import 'package:flutter/material.dart';
import 'package:ist_study/screens/home/home_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.school_rounded),
        title: Text("ISTudy", style: Theme.of(context).textTheme.headline4),
      ),
      body: HomeScreen(),
    );
  }
}
