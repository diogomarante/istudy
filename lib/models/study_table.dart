import 'dart:ui';

import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';

class StudyTable {
  String name;
  Room room;
  String state;
  bool pc;
  Color color;
  StudyTable(Map<String, dynamic> table, Room room) {
    this.name = table["name"];
    this.room = room;
    this.state = table["state"].toString();
    this.pc = table["hasPc"];
    this.color = table["state"] == 0
        ? cleaned
        : table["state"] == 1
            ? dirty
            : occupied;
  }
}
