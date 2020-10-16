import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        width: 370,
        decoration: BoxDecoration(
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 4,
                spreadRadius: 2)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 180,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Theme.of(context).canvasColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                    ),
                    BoxShadow(
                        //color: Theme.of(context).shadowColor,
                        color: Colors.red,
                        blurRadius: 4,
                        spreadRadius: -12)
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Lab2",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
                Text("Informática I",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
                SizedBox(height: 40),
                Text("Fri, 12 Oct",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white)),
                Text("12:00 - 12:30",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 45,
                width: 45,
                child: Material(
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: InkWell(
                    onTap: () => {},
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.headline1.color,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
