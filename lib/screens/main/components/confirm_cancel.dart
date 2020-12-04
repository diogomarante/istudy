import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class ConfirmCancel extends StatelessWidget {
  final String type;
  final Function onClick;
  final Map<String, List<String>> texts = {
    "switch": [
      "In order to book a new table, your current reservation will be ",
      "checked-out",
      "."
    ],
    "cancel": [
      "Are you sure you want to ",
      "cancel ",
      "your current reservation?"
    ],
    "checkout": ["Are you sure you want to ", "check-out", "?"],
    "logout": ["Are you sure you want to ", "logout", "?"],
  };
  final Map<String, List<String>> buttons = {
    "switch": ["No, ignore", "Proceed"],
    "cancel": ["No, ignore", "Yes, cancel"],
    "cancelReservation": ["No, ignore", "Yes, cancel"],
    "cancelSession": ["No, ignore", "Yes, cancel"],
    "checkout": ["No, stay", "Yes, check-out"],
    "logout": ["No, stay", "Yes, logout"],
  };

  ConfirmCancel({
    Key key,
    @required this.type,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 220,
        width: 500,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: texts[type][0],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextSpan(
                    text: texts[type][1],
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.orange),
                  ),
                  TextSpan(
                    text: texts[type][2],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: type == "switch" ? 20 : 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onClick();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.orange,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    buttons[type][1],
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text("close",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: blue)),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
