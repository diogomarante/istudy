import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/style/colors.dart';

class ReservationTimer extends StatelessWidget {
  final Reservation reservation;

  ReservationTimer({
    Key key,
    @required this.reservation,
  }) : super(key: key);

  String buildTimer() {
    int timer = reservation.checkIn
        ? reservation.end.difference(DateTime.now()).inSeconds
        : reservation.duration;
    int seconds = timer % 60;
    int minutes = timer ~/ 60;
    int hours = minutes ~/ 60;
    minutes = minutes % 60;
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
      style: Theme.of(context).textTheme.headline1.copyWith(color: blue),
    );
  }
}
