import 'package:flutter/material.dart';

class CheckInTimer extends StatelessWidget {
  final int timer;

  CheckInTimer({
    Key key,
    @required this.timer,
  }) : super(key: key);

  String buildTimer() {
    int seconds = timer % 60;
    int minutes = timer ~/ 60;
    int hours = minutes ~/ 60;
    String builder = "0" +
        hours.toString() +
        ":" +
        (minutes < 10 ? "0" + minutes.toString() : minutes.toString()) +
        ":" +
        (seconds < 10 ? "0" + seconds.toString() : seconds.toString());
    return builder;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      buildTimer(),
      style:
          Theme.of(context).textTheme.headline3.copyWith(color: Colors.orange),
    );
  }
}
