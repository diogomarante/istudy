import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class TableFilters extends StatelessWidget {
  final bool computer;
  final bool available;
  final Function toggleAvailable;
  final Function toggleComputer;

  TableFilters({
    Key key,
    @required this.computer,
    @required this.available,
    @required this.toggleAvailable,
    @required this.toggleComputer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select a ", style: Theme.of(context).textTheme.headline4),
            Text("table",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: blue)),
          ],
        ),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: toggleAvailable,
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: available ? blue.withOpacity(0.2) : Colors.transparent,
              ),
              child: Center(
                child: Text("available",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: blue)),
              ),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: toggleComputer,
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: computer ? blue.withOpacity(0.2) : Colors.transparent,
              ),
              child: Center(
                child: Text("computer",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: blue)),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
