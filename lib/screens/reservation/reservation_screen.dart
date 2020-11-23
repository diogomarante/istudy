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

  ReservationScreen({
    Key key,
    @required this.reservation,
    @required this.onCancel,
    @required this.onCheckout,
    @required this.onExtend,
    @required this.onCheckIn,
    @required this.onBack,
    @required this.checkInTimer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: SizedBox()),
      ReservationNavigator(onBack: onBack),
      Expanded(child: SizedBox()),
      ReservationInfo(reservation: reservation),
      Expanded(child: SizedBox()),
      ReservationTimer(reservation: reservation),
      Expanded(child: SizedBox()),
      !reservation.checkIn && reservation.table.dirty
          ? Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    children: [
                      TextSpan(
                          text: "Wait until your table is cleaned.",
                          style: TextStyle(color: dirtyColor)),
                    ]),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(text: "Scan ", style: TextStyle(color: blue)),
                        TextSpan(
                          text: "the QR code on  ",
                        ),
                        TextSpan(
                            text: "table " + reservation.table.name,
                            style: TextStyle(color: blue)),
                        TextSpan(
                          text: " to ",
                        ),
                        TextSpan(
                            text: !reservation.checkIn ? "check-in" : "extend",
                            style: TextStyle(color: blue)),
                        TextSpan(
                            text:
                                !reservation.checkIn ? "." : " your session."),
                      ])),
            ),
      Expanded(child: SizedBox()),
      Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: (reservation.table.dirty && !reservation.checkIn) ||
                    (reservation.checkIn && reservation.duration > 1800)
                ? 0.1
                : 1,
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/scan.PNG'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          reservation.table.dirty && !reservation.checkIn
              ? CircularProgressIndicator()
              : Container(),
        ],
      ),
      Expanded(child: SizedBox()),
      !reservation.checkIn
          ? reservation.table.dirty
              ? Text(
                  "Talk to a staff member for more info.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              : Column(
                  children: [
                    Text(
                      "Check-in expires in:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CheckInTimer(timer: checkInTimer),
                  ],
                )
          : Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "You may  ",
                        ),
                        TextSpan(
                            text: "extend ", style: TextStyle(color: blue)),
                        TextSpan(
                          text: " to ",
                        ),
                        TextSpan(
                            text:
                                "your session when there are 30 minutes left on the timer."),
                      ])),
            ),
      Expanded(child: SizedBox()),
      Buttons(
          reservation: reservation,
          onCancel: onCancel,
          onCheckout: onCheckout,
          onExtend: onExtend,
          onCheckIn: onCheckIn,
          checkIn: reservation.checkIn),
      SizedBox(height: 40),
    ]);
  }
}
