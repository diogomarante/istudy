import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class RoomNavigator extends StatelessWidget {
  final Function onBack;
  RoomNavigator({
    Key key,
    @required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(children: [
        GestureDetector(
          onTap: onBack,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: blue,
          ),
        ),
        GestureDetector(onTap: onBack, child: SizedBox(width: 10)),
        GestureDetector(
          onTap: onBack,
          child: Text(
            "Home",
            style: Theme.of(context).textTheme.headline4.copyWith(color: blue),
          ),
        ),
      ]),
    );
  }
}
