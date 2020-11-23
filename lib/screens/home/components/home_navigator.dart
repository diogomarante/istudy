import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';
import 'dart:math' as math;

class HomeNavigator extends StatelessWidget {
  final Function onClick;
  final Function onLogout;
  final bool reservation;
  final Uint8List photo;

  HomeNavigator({
    Key key,
    @required this.onClick,
    @required this.onLogout,
    @required this.reservation,
    @required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        GestureDetector(
          onTap: onLogout,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: blue,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: MemoryImage(photo),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onLogout,
          child: Text(
            "logout",
            style: Theme.of(context).textTheme.headline4.copyWith(color: blue),
          ),
        ),
        Expanded(child: SizedBox()),
        reservation
            ? Row(children: [
                GestureDetector(
                  onTap: onClick,
                  child: Text(
                    "Table",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: blue),
                  ),
                ),
                GestureDetector(onTap: onClick, child: SizedBox(width: 10)),
                GestureDetector(
                  onTap: onClick,
                  child: Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: blue,
                    ),
                  ),
                ),
              ])
            : Container(),
      ]),
    );
  }
}
