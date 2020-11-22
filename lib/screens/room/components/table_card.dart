import 'package:flutter/material.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableCard extends StatelessWidget {
  final StudyTable table;
  final Function onClick;
  TableCard({
    Key key,
    @required this.table,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7, left: 7),
      child: GestureDetector(
        onTap: () =>
            table.reservation["istID"] == null ? onClick(table) : () {},
        child: Container(
            height: 131,
            width: 91,
            decoration: BoxDecoration(
              color: table.reservation["istID"] == null
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: table.reservation["istID"] == null
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 4),
                        spreadRadius: 4,
                        blurRadius: 10,
                      ),
                    ]
                  : [],
            ),
            child: Column(children: [
              SizedBox(height: 20),
              Text(table.name, style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 10),
              table.pc
                  ? SvgPicture.asset(
                      "assets/images/personal-computer.svg",
                      height: 30,
                      color: table.reservation["istID"] == null
                          ? blue
                          : Colors.grey,
                    )
                  : SizedBox(height: 30),
              SizedBox(height: 15),
              Container(
                height: 14,
                width: 60,
                decoration: BoxDecoration(
                  color: table.color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
