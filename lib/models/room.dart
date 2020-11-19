import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/study_table.dart';

class Room {
  String name;
  Building building;
  int maxOccupancy;
  int occupancy;
  List<StudyTable> tables = List<StudyTable>();
  bool favorite;
  int usage = 0;
  int cleaned = 0;
  int dirty = 0;
  int PCs = 0;
  bool pc = false;

  Room(Map<String, dynamic> room, Building building) {
    this.name = room["name"].toString();
    this.building = building;
    this.maxOccupancy = room["tables"].length;
    for (int i = 0; i < this.maxOccupancy; i++) {
      StudyTable table = StudyTable(room["tables"][i], this);
      tables.add(table);
      if (table.state == "0") {
        this.cleaned++;
      }
      if (table.state == "1") {
        this.dirty++;
      }
      this.PCs += table.pc ? 1 : 0;
      this.pc = this.pc || (table.pc && table.state == "0");
    }
  }

  void increment() {
    usage++;
  }

  void addTable(StudyTable table) {
    tables.add(table);
  }
}
