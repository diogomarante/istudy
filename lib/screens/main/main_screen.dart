import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/campus.dart';
import 'package:ist_study/models/fenix_user.dart';
import 'package:ist_study/models/reservation.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/home/home_screen.dart';
import 'package:ist_study/screens/main/components/confirm_booking.dart';
import 'package:ist_study/screens/main/components/confirm_cancel.dart';
import 'package:ist_study/screens/reservation/reservation_screen.dart';
import 'package:ist_study/screens/room/room_screen.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MainScreen extends StatefulWidget {
  final Campus campus;
  final Function onLogout;
  final FenixUser user;
  Reservation reservation;

  MainScreen({
    Key key,
    @required this.campus,
    @required this.onLogout,
    @required this.user,
  }) : super(key: key) {
    for (Building b in campus.buildings) {
      for (Room r in b.rooms) {
        for (StudyTable t in r.tables) {
          if (t.reservation["istID"] == user.istID) {
            reservation = Reservation(res: t.reservation, table: t);
          }
        }
      }
    }
  }

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedBuilding;
  Room selectedRoom;
  StudyTable selectedTable;
  int seconds = 1800;
  int checkInTimer = 900;
  String selectedPage;
  Timer chTimer;
  Timer resTimer;

  @override
  void initState() {
    super.initState();
    this.selectedBuilding = "rnl";
    if (widget.reservation != null &&
        !widget.reservation.table.reservation["checked"] &&
        !widget.reservation.table.dirty &&
        checkInTimer == 900) {
      selectedPage = "reservation";
      chTimer = startCheckInTimer();
    }
    if (widget.reservation != null &&
        widget.reservation.table.reservation["checked"]) {
      selectedPage = "reservation";

      resTimer = startReservationTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    chTimer.cancel();
    resTimer.cancel();
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
            table: table ?? widget.reservation.table ?? selectedTable,
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
            onClick: checkout,
          );
        });
  }

  void confirmSwitch(StudyTable table) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "switch",
            onClick: () {
              cancelReservation();
              confirmBooking(table);
            },
          );
        });
  }

  void logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmCancel(
            type: "logout",
            onClick: widget.onLogout,
          );
        });
  }

  void selectTable(StudyTable table) {
    this.setState(() {
      selectedTable = table;
    });
    if (widget.reservation != null) {
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
    //String cameraScanResult = await scanner.scan();
    await scanner.scan();
    updateFB(
        buildFBReservation(
            seconds,
            Timestamp.fromDate(DateTime.now().add(Duration(seconds: seconds))),
            Timestamp.fromDate(DateTime.now()),
            widget.user.istID,
            false),
        selectedTable.dirty,
        selectedTable);

    // if (selectedTable.dirty == false) {
    //   startCheckInTimer();
    // }

    this.setState(() {
      selectedPage = "reservation";
      seconds = 1800;
    });
  }

  void extendReservation() {
    updateFB(
        buildFBReservation(
            widget.reservation.duration + seconds,
            Timestamp.fromDate(
                (widget.reservation.table.reservation["endTime"] as Timestamp)
                    .toDate()
                    .add(Duration(seconds: seconds))),
            widget.reservation.table.reservation["initTime"],
            widget.user.istID,
            true),
        true,
        widget.reservation.table);
  }

  void cancelReservation() {
    updateFB(buildFBReservation(null, null, null, null, false),
        widget.reservation.table.dirty, widget.reservation.table);
    this.setState(() {
      selectedPage = "home";
    });
  }

  void checkIn() async {
    // String cameraScanResult = await scanner.scan();
    // print(cameraScanResult);
    updateFB(
        buildFBReservation(
            widget.reservation.duration,
            Timestamp.fromDate(DateTime.now()
                .add(Duration(seconds: widget.reservation.duration))),
            Timestamp.fromDate(DateTime.now()),
            widget.user.istID,
            true),
        true,
        widget.reservation.table);
    startReservationTimer();
  }

  void checkout() {
    updateFB(buildFBReservation(null, null, null, null, false), true,
        widget.reservation.table);
    this.setState(() {
      widget.reservation = null;
      selectedRoom = null;
      selectedPage = "home";
      selectedTable = null;
    });
  }

  Timer startReservationTimer() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.reservation == null) {
        timer.cancel();
        return;
      }

      if (widget.reservation.duration == 0) {
        cancelReservation();
        timer.cancel();
      }
      setState(() {});
    });
  }

  Timer startCheckInTimer() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.reservation != null &&
          !widget.reservation.checkIn &&
          checkInTimer == 0) {
        cancelReservation();
        timer.cancel();
        this.setState(() {
          checkInTimer = 900;
        });
      } else if (widget.reservation == null || widget.reservation.checkIn) {
        timer.cancel();
        this.setState(() {
          checkInTimer = 900;
        });
      } else {
        this.setState(() {
          checkInTimer -= 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.reservation != null && selectedPage == "reservation")
        ? ReservationScreen(
            reservation: widget.reservation,
            onCancel: confirmCancel,
            onCheckout: confirmCheckout,
            onExtend: confirmExtend,
            onCheckIn: checkIn,
            onBack: togglePage,
            checkInTimer: checkInTimer)
        : (selectedRoom != null && selectedPage == "room")
            ? RoomScreen(
                room: widget.campus
                    .getBuilding(selectedRoom.building.name)
                    .getRoom(selectedRoom.name),
                onClick: selectTable,
                onToggleFavorite: toggleFavorite,
                onBack: clearSelection,
              )
            : HomeScreen(
                selectedBuilding: widget.campus.getBuilding(selectedBuilding),
                onSwitch: switchBuilding,
                onRoomSelect: selectRoom,
                onTogglePage: togglePage,
                onLogout: logout,
                buildings: widget.campus.buildings,
                reservation: widget.reservation != null,
                user: widget.user,
              );
  }

  Map<String, dynamic> buildFBRoom(
      String name, List<Map<String, dynamic>> tables, List<dynamic> favorites) {
    print(favorites);
    return {
      'favorites': favorites,
      'tables': tables,
      'name': name,
    };
  }

  Map<String, dynamic> buildFBTable(
      bool hasPc, String name, Map<String, dynamic> res, bool dirty) {
    return {
      'dirty': dirty,
      'hasPc': hasPc,
      'name': name,
      'reservation': res,
    };
  }

  Map<String, dynamic> buildFBReservation(int duration, Timestamp endTime,
      Timestamp initTime, String istID, bool checked) {
    return {
      'duration': duration,
      'istID': istID,
      'checked': checked,
      'endTime': endTime,
      'initTime': initTime,
    };
  }

  void toggleFavorite(Room toggleRoom) {
    List<Map<String, dynamic>> updatedRooms = List<Map<String, dynamic>>();
    for (Room room in toggleRoom.building.rooms) {
      List<dynamic> newFavorites =
          room.favorites != null ? room.favorites : List<dynamic>();
      if (room.name == toggleRoom.name) {
        if (toggleRoom.favorite) {
          newFavorites.remove(widget.user.istID);
        } else {
          newFavorites.add(widget.user.istID);
        }
      }
      updatedRooms.add(buildFBRoom(
          room.name,
          room.tables
              .map((e) => buildFBTable(e.pc, e.name, e.reservation, e.dirty))
              .toList(),
          newFavorites));
    }
    FirebaseFirestore.instance.collection("tecnico4").get().then((docs) {
      for (var doc in docs.docs) {
        if (doc.data()["name"] == toggleRoom.building.name) {
          doc.reference.update({
            "rooms": updatedRooms,
          });
        }
      }
    });
  }

  void updateFB(Map<String, dynamic> newRes, bool dirty, StudyTable argtable) {
    List<Map<String, dynamic>> updatedRooms = List<Map<String, dynamic>>();
    for (Room room in argtable.room.building.rooms) {
      List<Map<String, dynamic>> updatedTables = List<Map<String, dynamic>>();
      for (StudyTable table in room.tables) {
        Map<String, dynamic> updatedRes;
        bool updatedDirty;
        if ((argtable.name == table.name) &&
            (argtable.room.name == room.name)) {
          updatedRes = newRes;
          updatedDirty = dirty;
        } else {
          updatedRes = table.reservation;
          updatedDirty = table.dirty;
        }
        updatedTables
            .add(buildFBTable(table.pc, table.name, updatedRes, updatedDirty));
      }
      updatedRooms.add(buildFBRoom(room.name, updatedTables, room.favorites));
    }
    FirebaseFirestore.instance.collection("tecnico4").get().then((docs) {
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
