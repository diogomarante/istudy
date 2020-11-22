import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';

class Building {
  String name;
  List<Room> rooms = List<Room>();
  int cleaned = 0;
  int dirty = 0;
  bool pc = false;
  int PCs = 0;

  Building({@required Map<String, dynamic> building, @required Function setReservation, @required String istID}) {
    this.name = building["name"];
    for (var i = 0; i < building["rooms"].length; i++) {
      Room room = Room(building["rooms"][i], this, setReservation, istID);
      this.rooms.add(room);
      this.cleaned += room.cleaned;
      this.dirty += room.dirty;
      this.PCs += room.PCs;
      this.pc = room.pc || this.pc;
    }
  }

  addRoom(Room room) {
    this.rooms.add(room);
  }
}
