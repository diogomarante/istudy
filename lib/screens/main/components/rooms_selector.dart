import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class RoomsSelector extends StatelessWidget {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: width / 2 - 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Informática 1",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down_rounded),
                  iconSize: 35,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
