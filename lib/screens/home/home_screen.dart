import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/screens/home/components/buildings_dropdown.dart';
import 'package:ist_study/screens/home/components/home_navigator.dart';
import 'package:ist_study/screens/home/components/room_card.dart';
import 'package:ist_study/screens/home/components/rooms_selector.dart';

class HomeScreen extends StatefulWidget {
  final Building selectedBuilding;
  final Function onSwitch;
  final Function onRoomSelect;
  final Function onTogglePage;
  final List<Building> buildings;
  final bool reservation;

  HomeScreen({
    Key key,
    @required this.selectedBuilding,
    @required this.onSwitch,
    @required this.onRoomSelect,
    @required this.onTogglePage,
    @required this.buildings,
    @required this.reservation,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showingDropdown = false;

  toggleDropdown() {
    this.setState(() {
      showingDropdown = !showingDropdown;
    });
  }

  List<Widget> renderRooms(List<Room> rooms, Function onClick) {
    List<Widget> cards = List<Widget>();
    for (int i = 0; i < rooms.length; i += 2) {
      cards.add(i != rooms.length - 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoomCard(room: rooms[i], onClick: onClick),
                RoomCard(room: rooms[i + 1], onClick: onClick),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoomCard(room: rooms[i], onClick: onClick),
                SizedBox(
                  width: 170,
                )
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
        renderRooms(widget.selectedBuilding.rooms, widget.onRoomSelect);
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                HomeNavigator(
                  onClick: widget.onTogglePage,
                  reservation: widget.reservation,
                ),
                SizedBox(
                  height: height / 2 - 40,
                ),
                RoomsSelector(
                    onClick: toggleDropdown,
                    selectedBuilding: widget.selectedBuilding,
                    showingDropdown: showingDropdown,
                    active: true),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cards,
                ),
              ],
            ),
          ),
          showingDropdown
              ? Positioned(
                  top: height / 2 + 53,
                  child: BuildingsDropdown(
                    buildings: widget.buildings,
                    selectedBuilding: widget.selectedBuilding,
                    onClick: (Building building) {
                      widget.onSwitch(building);
                      toggleDropdown();
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
