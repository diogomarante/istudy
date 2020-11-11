import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';

class Reservation {
  final Building building;
  final Room room;
  final StudyTable table;
  int endTime; //in seconds
  Reservation(
      {@required this.building,
      @required this.room,
      @required this.table,
      @required this.endTime});

  void extend(int seconds) {
    endTime += seconds;
  }
}
