import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  RoomCard({
    Key key,
    @required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 156,
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 19),
                child: Column(
                  children: [
                    Row(children: [
                      Text(room.name,
                          style: Theme.of(context).textTheme.button),
                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      Container(
                        height: 21,
                        width: 27,
                        alignment: Alignment(0.0, 0.0),
                        decoration: BoxDecoration(
                          color: cleaned,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text("10"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 21,
                        width: 27,
                        alignment: Alignment(0.0, 0.0),
                        decoration: BoxDecoration(
                          color: dirty,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text("10"),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      SvgPicture.asset(
                        "assets/images/personal-computer.svg",
                        height: 30,
                        color: blue,
                      )
                    ])
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 10,
            child: Container(
              height: 25,
              width: 52,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Icon(
                      Icons.star_rate_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
