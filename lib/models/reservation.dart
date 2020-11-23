import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ist_study/models/study_table.dart';

class Reservation {
  final StudyTable table;
  int duration; //in minutes
  bool checkIn = false;
  DateTime end;

  Reservation({@required Map<String, dynamic> res, @required this.table}) {
    duration = res["duration"];
    checkIn = res["checked"];
    end = (res["endTime"] as Timestamp).toDate();
  }
}
