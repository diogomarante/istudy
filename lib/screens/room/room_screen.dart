import 'package:flutter/material.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/room/components/room_info.dart';
import 'package:ist_study/screens/room/components/table_card.dart';
import 'package:ist_study/screens/room/components/table_filters.dart';
import 'components/room_navigator.dart';

class RoomScreen extends StatefulWidget {
  final Room room;
  final Function onClick;
  final Function onBack;
  final Function onToggleFavorite;

  RoomScreen({
    Key key,
    @required this.room,
    @required this.onClick,
    @required this.onBack,
    @required this.onToggleFavorite,
  }) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool cleaned = true;
  bool dirty = true;
  bool occupied = true;
  bool computer = true;
  int minutes;

  toggleComputer() {
    this.setState(() {
      computer = !computer;
    });
  }

  toggleCleaned() {
    this.setState(() {
      cleaned = !cleaned;
    });
  }

  toggleDirty() {
    this.setState(() {
      dirty = !dirty;
    });
  }

  toggleOccupied() {
    this.setState(() {
      occupied = !occupied;
    });
  }

  List<StudyTable> filterTables(List<StudyTable> tables) {
    List<StudyTable> filteredTables = List<StudyTable>();
    for (int i = 0; i < tables.length; i++) {
      if (cleaned &&
          (tables[i].reservation["istID"] == null && !tables[i].dirty)) {
        if (computer && tables[i].pc) {
          filteredTables.add(tables[i]);
          continue;
        }
      }

      if (dirty &&
          (tables[i].reservation["istID"] == null && tables[i].dirty)) {
        if (computer && tables[i].pc) {
          filteredTables.add(tables[i]);
          continue;
        }
      }

      if (occupied && tables[i].reservation["istID"] != null) {
        if (computer && tables[i].pc) {
          filteredTables.add(tables[i]);
          continue;
        }
      }
    }

    filteredTables
        .sort((a, b) => (int.parse(a.name).compareTo(int.parse(b.name))));
    return filteredTables;
  }

  List<Widget> renderTables(List<StudyTable> tables, Function onClick) {
    List<Widget> cards = List<Widget>();
    for (int i = 0; i < tables.length; i += 3) {
      cards.add(i < tables.length - 2
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TableCard(table: tables[i], onClick: onClick),
                TableCard(table: tables[i + 1], onClick: onClick),
                TableCard(table: tables[i + 2], onClick: onClick),
              ],
            )
          : i < tables.length - 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TableCard(table: tables[i], onClick: onClick),
                    TableCard(table: tables[i + 1], onClick: onClick),
                    SizedBox(
                      width: 105,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TableCard(table: tables[i], onClick: onClick),
                    SizedBox(
                      width: 210,
                    ),
                  ],
                ));
      cards.add(SizedBox(
        height: 15,
      ));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    final cards =
        renderTables(filterTables(widget.room.tables), widget.onClick);
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 20),
        RoomNavigator(
            onBack: widget.onBack,
            onToggleFavorite: widget.onToggleFavorite,
            room: widget.room),
        SizedBox(height: 50),
        RoomInfo(room: widget.room),
        SizedBox(height: 30),
        TableFilters(
            computer: computer,
            cleaned: cleaned,
            dirty: dirty,
            occupied: occupied,
            toggleCleaned: toggleCleaned,
            toggleDirty: toggleDirty,
            toggleOccupied: toggleOccupied,
            toggleComputer: toggleComputer),
        SizedBox(height: 30),
        Column(
          children: cards,
        )
      ]),
    );
  }
}
