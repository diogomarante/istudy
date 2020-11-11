import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';

class ReservationStatus extends StatelessWidget {
  final State state;
  final Function execute;
  final Function cancel;
  final Reservation reservation;

  const ReservationStatus(
      {Key key, this.state, this.execute, this.cancel, this.reservation})
      : super(key: key);

  title() {
    return Text("Table ready");
  }

  room() {
    return Text("room");
  }

  building() {
    return Text("building");
  }

  qrcode() {
    return Container();
  }

  help() {
    return Text("help");
  }

  buttons() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      title(),
      room(),
      building(),
      qrcode(),
      help(),
      buttons(),
    ]);
  }
}
