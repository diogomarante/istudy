import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/study_table.dart';

class Room {
  final String name;
  final Building building;
  final List<StudyTable> tables;
  bool favorite;
  int usage = 0;
  int occupancy;
  bool full;

  Room(
      {@required this.name,
      @required this.building,
      @required this.tables,
      @required this.occupancy}) {
    full = occupancy == tables.length;
  }

  void increment() {
    usage++;
  }
}
