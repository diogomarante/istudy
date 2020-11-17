import 'package:flutter/material.dart';

class BuildingsDropdown extends StatelessWidget {
  Widget buildingRow(building) {}

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 332,
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
        child: Column());
  }
}
