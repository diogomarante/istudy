import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/campus.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/home/home_screen.dart';
import 'package:ist_study/screens/main/components/confirm_booking.dart';
import 'package:ist_study/screens/main/components/confirm_cancel.dart';
import 'package:ist_study/screens/reservation/reservation_screen.dart';
import 'package:ist_study/screens/room/room_screen.dart';
import 'package:ist_study/style/colors.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MainScreen extends StatefulWidget {
  final Campus campus;

  MainScreen({
    Key key,
    @required this.campus,
  }) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedBuilding;
  Room selectedRoom;
  StudyTable selectedTable;
  Reservation reservation;
  bool tableReady = false;
  bool scanning = false;
  bool checkedIn = false;
  bool cleaned = true;
  int seconds = 1800;
  int checkInTimer = 900;
  String selectedPage;

  @override
  void initState() {
    print("yo");
    super.initState();
    this.selectedBuilding = "rnl";
  }

  void switchBuilding(Building building) {
    this.setState(() {
      selectedBuilding = building.name;
    });
  }

  void selectRoom(Room room) {
    this.setState(() {
      selectedRoom = room;
      selectedPage = "room";
    });
  }

  void confirmBooking(StudyTable table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmBooking(
            table: table ?? reservation.table ?? selectedTable,
            onUpdate: updateSeconds,
            onConfirm: makeReservation,
            extending: false,
            seconds: seconds,
          );
        });
  }

  void confirmExtend(StudyTable table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmBooking(
            table: table,
            onUpdate: updateSeconds,
            onConfirm: extendReservation,
            extending: true,
            seconds: seconds,
          );
        });
  }

  void confirmCancel() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "cancel",
            onClick: cancelReservation,
          );
        });
  }

  void confirmCheckout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "checkout",
            onClick: cancelReservation,
          );
        });
  }

  void confirmSwitch(StudyTable table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "switch",
            onClick: () => confirmBooking(table),
          );
        });
  }

  void logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "logout",
            onClick: () {},
          );
        });
  }

  void selectTable(StudyTable table) {
    this.setState(() {
      selectedTable = table;
    });
    if (reservation != null) {
      confirmSwitch(table);
    } else {
      confirmBooking(table);
    }
  }

  void clearSelection() {
    this.setState(() {
      selectedRoom = null;
    });
  }

  void updateSeconds(int sec) {
    this.setState(() {
      seconds = sec;
    });
  }

  void togglePage() {
    this.setState(() {
      selectedPage = selectedPage == "home" ? "reservation" : "home";
    });
  }

  void makeReservation() async {
    // String cameraScanResult = await scanner.scan();
    // print(cameraScanResult);
    print(selectedTable.name);
    updateFB(buildFBReseravtion(null, null, null, null), 3, selectedTable);

    if (selectedTable.state == "0") {
      startCheckInTimer();
    }

    this.setState(() {
      reservation = Reservation(
          building: widget.campus.getBuilding(selectedBuilding),
          room: selectedRoom,
          table: selectedTable,
          duration: seconds);
      selectedPage = "reservation";
      seconds = 1800;
    });
  }

  void extendReservation() {
    updateFB(buildFBReseravtion(null, null, null, null), 4, reservation.table);
    this.setState(() {
      reservation.extend(seconds);
    });
  }

  //TODO how do i knwo what was the state before?
  void cancelReservation() {
    updateFB(buildFBReseravtion(null, null, null, null), 1, reservation.table);
    this.setState(() {
      reservation = null;
      selectedRoom = null;
      selectedPage = "home";
      selectedTable = null;
    });
  }

  void checkIn() async {
    // String cameraScanResult = await scanner.scan();
    // print(cameraScanResult);
    updateFB(buildFBReseravtion(null, null, null, null), 4, reservation.table);
    this.setState(() {
      reservation.checkin();
      checkedIn = true;
      checkInTimer = 0;
    });
    startReservationTimer(seconds);
  }

  void checkout() {
    updateFB(
        buildFBReseravtion(null, null, null, "toma"), 1, reservation.table);
    this.setState(() {
      reservation = null;
      selectedRoom = null;
      selectedPage = "home";
      selectedTable.state = "1";
      selectedTable.color = dirty;
      selectedTable = null;
    });
  }

  void startReservationTimer(int seconds) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (reservation == null) {
        timer.cancel();
        return;
      }
      setState(() {
        if (reservation.tick() == 0) {
          cancelReservation();
          timer.cancel();
        }
      });
    });
  }

  void startCheckInTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (checkInTimer == 0) {
        if (!checkedIn) cancelReservation();
        timer.cancel();
        this.setState(() {
          checkInTimer = 900;
        });
      }
      this.setState(() {
        checkInTimer -= 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (reservation != null && selectedPage == "reservation")
        ? ReservationScreen(
            reservation: reservation,
            onCancel: confirmCancel,
            onCheckout: confirmCheckout,
            onExtend: confirmExtend,
            onCheckIn: checkIn,
            onBack: togglePage,
            checkIn: checkedIn,
            cleaned: tableReady,
            checkInTimer: checkInTimer)
        : (selectedRoom != null && selectedPage == "room")
            ? RoomScreen(
                room: selectedRoom,
                onClick: selectTable,
                onBack: clearSelection,
              )
            : HomeScreen(
                selectedBuilding: widget.campus.getBuilding(selectedBuilding),
                onSwitch: switchBuilding,
                onRoomSelect: selectRoom,
                onTogglePage: togglePage,
                buildings: widget.campus.buildings,
                reservation: reservation != null,
              );
  }

  Map<String, dynamic> buildFBRoom(
      String name, List<Map<String, dynamic>> tables) {
    return {
      'name': name,
      'tables': tables,
    };
  }

  Map<String, dynamic> buildFBTable(
      bool hasPc, String name, Map<String, dynamic> res, int state) {
    return {
      'hasPc': hasPc,
      'name': name,
      'reservation': res,
      'state': state,
    };
  }

  Map<String, dynamic> buildFBReseravtion(
      int duration, Timestamp endTime, Timestamp initTime, String istID) {
    return {
      'duration': duration,
      'endTime': endTime,
      'initTime': initTime,
      'istID': istID,
    };
  }

  void updateFB(Map<String, dynamic> newRes, int state, StudyTable argtable) {
    List<Map<String, dynamic>> updatedRooms = List<Map<String, dynamic>>();
    for (Room room in argtable.room.building.rooms) {
      List<Map<String, dynamic>> updatedTables = List<Map<String, dynamic>>();
      for (StudyTable table in room.tables) {
        Map<String, dynamic> updatedRes;
        int updatedState;
        if ((argtable.name == table.name) &&
            (argtable.room.name == room.name)) {
          updatedRes = newRes;
          updatedState = state;
        } else {
          updatedRes = table.reservation;
          updatedState = int.parse(table.state);
        }
        updatedTables
            .add(buildFBTable(table.pc, table.name, updatedRes, updatedState));
      }
      updatedRooms.add(buildFBRoom(room.name, updatedTables));
    }
    FirebaseFirestore.instance.collection("tecnico1").get().then((docs) {
      for (var doc in docs.docs) {
        if (doc.data()["name"] == argtable.room.building.name) {
          doc.reference.update({
            "rooms": updatedRooms,
          });
        }
      }
    });
  }
}
