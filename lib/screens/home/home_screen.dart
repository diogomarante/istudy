import 'package:flutter/material.dart';
import 'package:ist_study/models/building.dart';
import 'package:ist_study/models/fenix_user.dart';
import 'package:ist_study/models/room.dart';
import 'package:ist_study/screens/home/components/buildings_dropdown.dart';
import 'package:ist_study/screens/home/components/home_navigator.dart';
import 'package:ist_study/screens/home/components/room_card.dart';
import 'package:ist_study/screens/home/components/rooms_selector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ist_study/style/colors.dart';

class HomeScreen extends StatefulWidget {
  final Building selectedBuilding;
  final Function onSwitch;
  final Function onRoomSelect;
  final Function onTogglePage;
  final Function onLogout;
  final List<Building> buildings;
  final bool reservation;
  final FenixUser user;

  HomeScreen({
    Key key,
    @required this.selectedBuilding,
    @required this.onSwitch,
    @required this.onRoomSelect,
    @required this.onTogglePage,
    @required this.onLogout,
    @required this.buildings,
    @required this.reservation,
    @required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showingDropdown = false;
  bool showingFavorites = false;

  toggleDropdown() {
    this.setState(() {
      showingDropdown = !showingDropdown;
    });
  }

  toggleFavorites() {
    this.setState(() {
      showingFavorites = !showingFavorites;
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

  List<Room> getFavorites() {
    List<Room> rooms = List<Room>();
    for (int i = 0; i < widget.buildings.length; i++) {
      for (int j = 0; j < widget.buildings[i].rooms.length; j++) {
        if (widget.buildings[i].rooms[j].favorite) {
          rooms.add(widget.buildings[i].rooms[j]);
        }
      }
    }
    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    final rooms =
        showingFavorites ? getFavorites() : widget.selectedBuilding.rooms;
    final cards = renderRooms(rooms, widget.onRoomSelect);
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
                  onLogout: widget.onLogout,
                  reservation: widget.reservation,
                  photo: widget.user.photo,
                ),
                SizedBox(
                  height: 40,
                ),
                SvgPicture.asset(
                  "assets/images/books.svg",
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Where would you like to study?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: blue,
                    )),
                SizedBox(
                  height: 30,
                ),
                RoomsSelector(
                    onClick: toggleDropdown,
                    selectedBuilding: widget.selectedBuilding,
                    onToggleFavorites: toggleFavorites,
                    showingDropdown: showingDropdown,
                    active: !showingFavorites),
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
