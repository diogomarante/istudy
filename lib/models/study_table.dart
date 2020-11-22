import 'dart:ui';

import 'package:ist_study/models/fenix_user.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/style/colors.dart';

class StudyTable {
  String name;
  Room room;
  bool dirty;
  bool pc;
  Color color;
  Map<String, dynamic> reservation;

  StudyTable(Map<String, dynamic> table, Room room) {
    this.name = table["name"];
    this.room = room;
    this.dirty = table["dirty"];
    this.pc = table["hasPc"];
    this.color = getColor(table);
    this.reservation = table["reservation"];
  }

  Color getColor(Map<String, dynamic> table) {
    if (table["reservation"]["istID"] != null) {
      return occupiedColor;
    }
    if (table["dirty"]) {
      return dirtyColor;
    }
    return cleanedColor;
  }
}
