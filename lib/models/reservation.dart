import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';

class Reservation {
  final Building building;
  final Room room;
  final StudyTable table;
  int duration; //in minutes
  bool checkIn = false;
  Reservation(
      {@required this.building,
      @required this.room,
      @required this.table,
      @required this.duration});

  void extend(int seconds) {
    duration += seconds;
  }

  void checkin() {
    checkIn = true;
  }

  int tick() {
    duration = duration - 1;
    return duration;
  }
}
