import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';

class Building {
  final String name;
  final List<Room> rooms;
  Building({@required this.name, @required this.rooms});
}
