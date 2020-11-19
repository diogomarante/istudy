import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';

class RoomInfo extends StatelessWidget {
  final Room room;

  RoomInfo({
    Key key,
    @required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 77,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            room.name,
            style: Theme.of(context).textTheme.headline1.copyWith(color: blue),
          ),
        ),
      ),
      SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 150,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(room.building.name,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: blue)),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 150,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text("Floor 1",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: blue)),
          ),
        ),
      ]),
    ]);
  }
}
