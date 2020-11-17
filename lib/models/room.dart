import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/study_table.dart';

class Room {
  final String name;
  final Building building;
  final int MAX_OCCUPANCY;
  final int occupancy;
  List<StudyTable> tables = List<StudyTable>();
  bool favorite;
  int usage = 0;

  Room({
    @required this.name,
    @required this.building,
    @required this.MAX_OCCUPANCY,
    @required this.occupancy,
    @required this.favorite,
  });

  void increment() {
    usage++;
  }

  void addTable(StudyTable table) {
    tables.add(table);
  }
}
