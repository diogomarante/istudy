import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/fenix_user.dart';

class Campus {
  String name;
  List<Building> buildings = List<Building>();
  int cleaned = 0;
  int dirty = 0;
  FenixUser user;

  Campus(
      {@required this.name,
      @required List<Map<String, dynamic>> buildings,
      @required this.user}) {
    this.name = name;
    for (int i = 0; i < buildings.length; i++) {
      Building building = Building(building: buildings[i], user: user);
      this.buildings.add(building);
      this.cleaned += building.cleaned;
      this.dirty += building.dirty;
    }
  }

  Building getBuilding(String name) {
    for (int i = 0; i < this.buildings.length; i++) {
      if (buildings[i].name == name) return buildings[i];
    }
    return null;
  }
}
