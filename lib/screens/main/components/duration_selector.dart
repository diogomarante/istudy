import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class DurationSelector extends StatefulWidget {
  final Function onUpdate;

  DurationSelector({
    Key key,
    @required this.onUpdate,
  }) : super(key: key);

  @override
  _DurationSelectorState createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  int minutes = 30;

  String getDuration(int minutes) {
    switch (minutes) {
      case 30:
        {
          return "0h30m";
        }
        break;
      case 60:
        {
          return "1h00m";
        }
        break;
      case 90:
        {
          return "1h30m";
        }
        break;
      case 120:
        {
          return "2h00m";
        }
        break;
      case 150:
        {
          return "2h30m";
        }
        break;
      case 180:
        {
          return "3h00m";
        }
        break;
      default:
        {
          return "error";
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              this.setState(() {
                minutes = minutes == 30 ? 30 : minutes - 30;
                widget.onUpdate(minutes == 30 ? 30 : minutes - 30);
                print(minutes.toString());
              });
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: minutes == 30 ? lightBlue : blue,
              ),
              child: Center(
                child: Text(
                  "-",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            width: 70,
            height: 32,
            color: lightGray,
            child: Center(
              child: Text(
                getDuration(minutes),
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("ola");
              this.setState(() {
                minutes = minutes == 180 ? 180 : minutes + 30;
                widget.onUpdate(minutes == 180 ? 180 : minutes + 30);
                print(minutes.toString());
              });
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: minutes == 180 ? lightBlue : blue,
              ),
              child: Center(
                child: Text(
                  "+",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ]);
  }
}
