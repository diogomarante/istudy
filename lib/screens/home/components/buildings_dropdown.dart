import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/style/colors.dart';

class BuildingsDropdown extends StatelessWidget {
  final List<Building> buildings;
  final Building selectedBuilding;
  final Function onClick;

  BuildingsDropdown({
    Key key,
    @required this.buildings,
    @required this.selectedBuilding,
    @required this.onClick,
  }) : super(key: key);

  Widget buildingRow(Building building, BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(building),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
        child: Row(
          children: [
            Text(
              building.name,
              style: selectedBuilding.name == building.name
                  ? Theme.of(context).textTheme.button.copyWith(color: blue)
                  : Theme.of(context).textTheme.button,
            ),
            Expanded(
              child: SizedBox(),
            ),
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
              child: Text(
                building.cleaned.toString(),
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
                color: dirty,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                building.dirty.toString(),
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < buildings.length; i++) {
      children.add(buildingRow(buildings[i], context));
    }
    return Container(
      width: 332,
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
      child: Column(
        children: children,
      ),
    );
  }
}
