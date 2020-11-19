import 'package:flutter/material.dart';
import 'package:ist_study/models/study_table.dart';
import 'package:ist_study/screens/main/components/duration_selector.dart';
import 'package:ist_study/style/colors.dart';

class ConfirmBooking extends StatelessWidget {
  final StudyTable table;
  final Function onUpdate;

  ConfirmBooking({
    Key key,
    @required this.table,
    @required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 230,
        width: 400,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text("How much time do you wish to  ",
                    style: Theme.of(context).textTheme.headline4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("study at ",
                        style: Theme.of(context).textTheme.headline4),
                    Text(table.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: blue)),
                    Text("?", style: Theme.of(context).textTheme.headline4),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            DurationSelector(onUpdate: onUpdate),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: lightBlue,
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
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => print("done"),
                child: Container(
                  height: 50,
                  width: 120,
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
                      "Book",
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
    ;
  }
}
