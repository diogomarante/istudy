import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/style/colors.dart';
import 'dart:math' as math;

class RoomsSelector extends StatelessWidget {
  final Function onClick;
  final Building selectedBuilding;
  final bool active;
  final bool showingDropdown;

  RoomsSelector({
    Key key,
    @required this.onClick,
    @required this.selectedBuilding,
    @required this.active,
    @required this.showingDropdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 332;
    double height = 47;
    double separatorWidth = 2;
    return Container(
      height: height,
      width: width,
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: width / 2 - separatorWidth / 2,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ]),
            ),
          ),
          Container(
            height: height,
            width: separatorWidth,
            color: gray400.withOpacity(0.4),
          ),
          Container(
            width: width / 2 - separatorWidth / 2,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width / 2 - separatorWidth / 2,
                      height: height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            selectedBuilding.name,
                            style: this.active
                                ? Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: blue)
                                : Theme.of(context).textTheme.button,
                          ),
                          // Expanded(
                          //   child: SizedBox(),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Transform.rotate(
                    angle: showingDropdown ? 180 * math.pi / 180 : 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: active ? blue : slate,
                      ),
                      iconSize: 35,
                      onPressed: onClick,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
