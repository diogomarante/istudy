import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class ConfirmExit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("yo");
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
                    text: "Are you sure you want to ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextSpan(
                    text: "exit",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.orange),
                  ),
                  TextSpan(
                    text: "?",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
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
                    "Exit",
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
