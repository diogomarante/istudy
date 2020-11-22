import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';
import 'dart:math' as math;

class OnboardingNavigator extends StatelessWidget {
  final Function onBack;
  final Function onNext;
  final int step;

  OnboardingNavigator({
    Key key,
    @required this.onBack,
    @required this.onNext,
    @required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        step != 1
            ? Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: blue,
                    ),
                  ),
                  GestureDetector(onTap: onBack, child: SizedBox(width: 10)),
                  GestureDetector(
                    onTap: onBack,
                    child: Text(
                      "back",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: blue),
                    ),
                  ),
                ]),
              )
            : SizedBox(),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Row(children: [
            GestureDetector(
              onTap: onNext,
              child: Text(
                "next",
                style:
                    Theme.of(context).textTheme.headline4.copyWith(color: blue),
              ),
            ),
            GestureDetector(onTap: onNext, child: SizedBox(width: 10)),
            GestureDetector(
              onTap: onNext,
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: blue,
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
