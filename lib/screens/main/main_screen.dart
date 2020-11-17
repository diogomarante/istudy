import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/main/components/buildings_dropdown.dart';
import 'package:ist_study/screens/main/components/rooms_selector.dart';
import 'components/room_card.dart';

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

  Building building = Building(name: "Informática 1");

  @override
  Widget build(BuildContext context) {
    Room room = Room(
        name: "Lab1",
        building: building,
        MAX_OCCUPANCY: 11,
        occupancy: 10,
        favorite: true);
    StudyTable table = StudyTable(name: "1", free: true);
    room.addTable(table);
    return Container(
      height: 500,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
/*
          RoomCard(room: room),
*/
          BuildingsDropdown(),
        ],
      ),
    );
  }
}
