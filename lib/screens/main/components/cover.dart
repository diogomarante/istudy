import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.6;
    double width = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      color: Colors.red,
    );
  }
}
