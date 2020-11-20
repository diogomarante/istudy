import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/screens/reservation/components/buttons.dart';
import 'package:ist_study/screens/reservation/components/check_in_timer.dart';
import 'package:ist_study/screens/reservation/components/reservation_info.dart';
import 'package:ist_study/screens/reservation/components/reservation_timer.dart';
import 'package:ist_study/style/colors.dart';
import 'components/reservation_navigator.dart';

class ReservationScreen extends StatelessWidget {
  final Reservation reservation;
  final Function onCancel;
  final Function onCheckout;
  final Function onExtend;
  final Function onCheckIn;
  final Function onBack;
  final int checkInTimer;
  final bool checkIn;
  final bool cleaned;

  ReservationScreen({
    Key key,
    @required this.reservation,
    @required this.onCancel,
    @required this.onCheckout,
    @required this.onExtend,
    @required this.onCheckIn,
    @required this.onBack,
    @required this.checkInTimer,
    @required this.checkIn,
    @required this.cleaned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      ReservationNavigator(onBack: onBack),
      SizedBox(height: 50),
      ReservationInfo(reservation: reservation),
      SizedBox(height: 50),
      ReservationTimer(reservation: reservation),
      SizedBox(height: 50),
      !checkIn ? CheckInTimer(timer: checkInTimer) : Container(),
      SizedBox(height: 50),
      Buttons(
          reservation: reservation,
          onCancel: onCancel,
          onCheckout: onCheckout,
          onExtend: onExtend,
          onCheckIn: onCheckIn,
          checkIn: checkIn),
    ]);
  }
}
