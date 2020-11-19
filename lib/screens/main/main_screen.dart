import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/campus.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'file:///C:/Users/diogo/OneDrive/Tecnico/2ano/CCU/ist_study/lib/screens/home/components/buildings_dropdown.dart';
import 'file:///C:/Users/diogo/OneDrive/Tecnico/2ano/CCU/ist_study/lib/screens/home/components/room_card.dart';
import 'file:///C:/Users/diogo/OneDrive/Tecnico/2ano/CCU/ist_study/lib/screens/home/components/rooms_selector.dart';
import 'package:ist_study/screens/home/home_screen.dart';
import 'package:ist_study/screens/main/components/confirm_booking.dart';
import 'package:ist_study/screens/main/components/duration_selector.dart';
import 'package:ist_study/screens/room/room_screen.dart';
import 'package:ist_study/style/colors.dart';

class MainScreen extends StatefulWidget {
  Campus campus;

  MainScreen({
    Key key,
    @required List<Map<String, dynamic>> buildings,
  }) : super(key: key) {
    this.campus = Campus(name: "Alameda", buildings: buildings);
  }

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Building selectedBuilding;
  Room selectedRoom;
  StudyTable selectedTable;
  Reservation reservation;
  bool tableReady = false;
  bool scanning = false;
  int minutes = 30;

  @override
  void initState() {
    this.selectedBuilding = widget.campus.getBuilding("rnl");
  }

  switchBuilding(Building building) {
    this.setState(() {
      selectedBuilding = building;
    });
  }

  selectRoom(Room room) {
    this.setState(() {
      selectedRoom = room;
    });
  }

  selectTable(StudyTable table) {
    print(table.name);
    this.setState(() {
      selectedTable = table;
    });
    _showDialog(table);
  }

  clearSelection() {
    this.setState(() {
      selectedRoom = null;
    });
  }

  updateMinutes(int min) {
    this.setState(() {
      minutes = min;
    });
  }

  void _showDialog(StudyTable table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmBooking(table: table, onUpdate: updateMinutes);
        });
  }

  @override
  Widget build(BuildContext context) {
    return selectedRoom != null
        ? RoomScreen(
            room: selectedRoom,
            onClick: selectTable,
            onBack: clearSelection,
          )
        : HomeScreen(
            selectedBuilding: selectedBuilding,
            onSwitch: switchBuilding,
            onRoomSelect: selectRoom,
            buildings: widget.campus.buildings,
          );
  }
}
