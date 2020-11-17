import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';

class Building {
  final String name;
  List<Room> rooms;
  Building({@required this.name});

  addRoom(Room room) {
    this.rooms.add(room);
  }
}
