import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableFilters extends StatelessWidget {
  final bool computer;
  final bool cleaned;
  final bool dirty;
  final bool occupied;
  final Function toggleCleaned;
  final Function toggleDirty;
  final Function toggleOccupied;
  final Function toggleComputer;

  TableFilters({
    Key key,
    @required this.computer,
    @required this.cleaned,
    @required this.dirty,
    @required this.occupied,
    @required this.toggleCleaned,
    @required this.toggleDirty,
    @required this.toggleOccupied,
    @required this.toggleComputer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Tables ", style: Theme.of(context).textTheme.headline4),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: toggleComputer,
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: computer ? Colors.white : Colors.grey.withOpacity(0.3),
                  boxShadow: computer
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(0, 2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/personal-computer.svg",
                    height: 30,
                    color: computer ? blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: toggleCleaned,
            child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: cleaned ? cleanedColor : Colors.grey.withOpacity(0.3),
                boxShadow: cleaned
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text("cleaned",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: cleaned ? Colors.black54 : Colors.grey)),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: toggleDirty,
            child: Container(
              height: 35,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: dirty ? dirtyColor : Colors.grey.withOpacity(0.3),
                boxShadow: dirty
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text("not cleaned",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: dirty ? Colors.black54 : Colors.grey)),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: toggleOccupied,
            child: Container(
              height: 35,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: occupied ? occupiedColor : Colors.grey.withOpacity(0.3),
                boxShadow: occupied
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text("occupied",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: occupied ? Colors.black54 : Colors.grey)),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
