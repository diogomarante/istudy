import 'package:flutter/material.dart';
import 'package:ist_study/screens/home/components/ticket.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),
      Center(child: Ticket()),
      SizedBox(height: 10),
      //TODO add lists here
      Expanded(child: SizedBox()),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          child: Container(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 4,
                  spreadRadius: 2)
            ],
            color: Theme.of(context).appBarTheme.color,
          )),
          onPressed: () => {},
        ),
      ),
    ]);
  }
}
