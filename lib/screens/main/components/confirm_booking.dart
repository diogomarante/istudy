import 'package:flutter/material.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/main/components/duration_selector.dart';
import 'package:ist_study/style/colors.dart';

class ConfirmBooking extends StatelessWidget {
  final StudyTable table;
  final Function onUpdate;
  final Function onConfirm;
  final int seconds;
  final bool extending;

  ConfirmBooking({
    Key key,
    @required this.table,
    @required this.onUpdate,
    @required this.onConfirm,
    @required this.seconds,
    @required this.extending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 240,
        width: 500,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: extending
                        ? "How long do you with to extend your session on "
                        : "How much time do you wish to study at ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextSpan(
                    text: table.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.blue),
                  ),
                  TextSpan(
                    text: "?",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DurationSelector(
              onUpdate: onUpdate,
              seconds: seconds,
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: blue,
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
                    extending ? "Extend" : "Book",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
