import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/main/components/cover.dart';
import 'package:ist_study/screens/main/components/reservatoion_status.dart';
import 'package:ist_study/screens/main/components/rooms_section.dart';
import 'package:ist_study/screens/main/components/submission_card.dart';
import 'package:ist_study/screens/main/components/tables_section.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Building selectedBuilding; //TODO change this to fenix mapping
  Room selectedRoom;
  StudyTable selectedTable;
  Reservation reservation;

  bool tableReady = false;
  bool scanning = false;

  @override
  Widget build(BuildContext context) {
    print("ola");
    return Column(children: [
      selectedRoom == null
          ? reservation == null
              ? Cover()
              : ReservationStatus()
          : TablesSection(),
      selectedTable != null && reservation == null
          ? SubmissionCard()
          : RoomsSection(),
    ]);
  }
}
