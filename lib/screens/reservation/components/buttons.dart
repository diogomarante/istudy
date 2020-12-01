import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/style/colors.dart';

class Buttons extends StatelessWidget {
  final Reservation reservation;
  final Function onCancel;
  final Function onCheckout;
  final Function onExtend;
  final Function onCheckIn;
  final bool checkIn;

  Buttons({
    Key key,
    @required this.reservation,
    @required this.onCancel,
    @required this.onCheckout,
    @required this.onExtend,
    @required this.onCheckIn,
    @required this.checkIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: !checkIn ? onCancel : onCheckout,
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.orange,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              !checkIn ? "Cancel" : "Check-out",
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      SizedBox(width: 20),
      GestureDetector(
        onTap: !checkIn
            ? onCheckIn
            : reservation.end.difference(DateTime.now()).inSeconds < 1800
                ? () => onExtend(reservation.table)
                : () {},
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: !checkIn && !reservation.table.dirty
                ? blue
                : reservation.end.difference(DateTime.now()).inSeconds < 1800
                    ? blue
                    : blue.withOpacity(0.2),
            boxShadow: !checkIn
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ]
                : reservation.end.difference(DateTime.now()).inSeconds < 1800
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
          ),
          child: Center(
            child: Text(
              !checkIn ? "Check-in" : "Extend",
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    ]);
  }
}
