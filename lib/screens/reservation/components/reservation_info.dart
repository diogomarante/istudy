import 'package:flutter/material.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReservationInfo extends StatelessWidget {
  final Reservation reservation;

  ReservationInfo({
    Key key,
    @required this.reservation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox()),
          Text(
            reservation.table.room.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Expanded(child: SizedBox()),
          Text(
            reservation.table.name,
            style: Theme.of(context).textTheme.headline1.copyWith(color: blue),
          ),
          SizedBox(width: 70),
          reservation.table.pc
              ? SvgPicture.asset(
                  "assets/images/personal-computer.svg",
                  height: 50,
                  color: blue,
                )
              : SizedBox(width: 60),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
