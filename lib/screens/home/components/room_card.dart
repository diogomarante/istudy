import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final Function onClick;
  RoomCard({
    Key key,
    @required this.room,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: SizedBox(
        width: 156,
        child: Stack(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => onClick(room),
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
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 4),
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
                              color: cleanedColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              room.cleaned.toString(),
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 21,
                            width: 27,
                            alignment: Alignment(0.0, 0.0),
                            decoration: BoxDecoration(
                              color: dirtyColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              room.dirty.toString(),
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          room.PCs > 0
                              ? SvgPicture.asset(
                                  "assets/images/personal-computer.svg",
                                  height: 30,
                                  color: room.pc ? blue : Colors.grey,
                                )
                              : Container(),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            room.favorite
                ? Positioned(
                    right: 0,
                    top: 10,
                    child: Container(
                      height: 25,
                      width: 52,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            child: Icon(
                              Icons.star_rate_rounded,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
