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
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                Text(
                  "Table " + reservation.table.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: blue),
                ),
                Expanded(child: SizedBox()),
                reservation.table.pc
                    ? SvgPicture.asset(
                        "assets/images/personal-computer.svg",
                        height: 40,
                        color: blue,
                      )
                    : SizedBox(width: 60),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(children: [
            Expanded(child: SizedBox()),
            Column(children: [
              Text("Room"),
              SizedBox(height: 5),
              Text(reservation.table.room.name,
                  style: Theme.of(context).textTheme.headline4),
            ]),
            Expanded(child: SizedBox()),
            Container(
              height: 30,
              width: 1,
              color: Colors.grey,
            ),
            Expanded(child: SizedBox()),
            Column(children: [
              Text("Building"),
              SizedBox(height: 5),
              Text(reservation.table.room.building.name,
                  style: Theme.of(context).textTheme.headline4),
            ]),
            Expanded(child: SizedBox()),
            Container(
              height: 30,
              width: 1,
              color: Colors.grey,
            ),
            Expanded(child: SizedBox()),
            Column(children: [
              Text("Floor"),
              SizedBox(height: 5),
              Text("1", style: Theme.of(context).textTheme.headline4),
            ]),
            Expanded(child: SizedBox()),
          ]),
        ],
      ),
    );
  }
}
