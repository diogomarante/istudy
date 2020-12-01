import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';

class CheckInTimer extends StatelessWidget {
  final Reservation reservation;

  CheckInTimer({
    Key key,
    @required this.reservation,
  }) : super(key: key);

  String buildTimer() {
    int diff = reservation.initTime
        .add(Duration(minutes: 15))
        .difference(DateTime.now())
        .inSeconds;
    int seconds = diff % 60;
    int minutes = diff ~/ 60;
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
