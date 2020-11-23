import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';

class RoomNavigator extends StatelessWidget {
  final Function onBack;
  final Function onToggleFavorite;
  final Room room;

  RoomNavigator({
    Key key,
    @required this.onBack,
    @required this.onToggleFavorite,
    @required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(children: [
            GestureDetector(
              onTap: onBack,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: blue,
              ),
            ),
            GestureDetector(onTap: onBack, child: SizedBox(width: 10)),
            GestureDetector(
              onTap: onBack,
              child: Text(
                "Home",
                style:
                    Theme.of(context).textTheme.headline4.copyWith(color: blue),
              ),
            ),
          ]),
        ),
        Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: GestureDetector(
              onTap: () => onToggleFavorite(room),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: room.favorite ? blue : Colors.grey,
                ),
                child: Center(
                  child: Icon(
                    Icons.star_rate_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
