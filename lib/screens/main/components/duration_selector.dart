import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class DurationSelector extends StatefulWidget {
  final Function onUpdate;
  final int seconds;

  DurationSelector({
    Key key,
    @required this.onUpdate,
    @required this.seconds,
  }) : super(key: key);

  @override
  _DurationSelectorState createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  int seconds;

  @override
  initState() {
    super.initState();
    seconds = widget.seconds;
  }

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
    String selectedDuration = getDuration(seconds ~/ 60);
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onUpdate(seconds == 1800 ? 1800 : seconds - 1800);
              setState(() {
                seconds = seconds == 1800 ? 1800 : seconds - 1800;
              });
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: seconds == 1800 ? lightBlue : blue,
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
                selectedDuration,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onUpdate(seconds == 10800 ? 10800 : seconds + 1800);
              setState(() {
                seconds = seconds == 10800 ? 10800 : seconds + 1800;
              });
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: seconds == 10800 ? lightBlue : blue,
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
