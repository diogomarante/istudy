import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  RoomCard({
    Key key,
    @required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 70,
      color: Colors.white,
      child: Row(children: [
        Icon(Icons.laptop),
        Column(children: [
          Row(children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: room.full ? Colors.red : Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            Text(room.name),
            Icon(
              Icons.star_rate_rounded,
              color: room.favorite ? blue : lightBlue,
            )
          ]),
          Text(room.building.name),
        ]),
      ]),
    );
  }
}
