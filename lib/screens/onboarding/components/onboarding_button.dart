import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';

class OnboardingButton extends StatelessWidget {
  final Function onClick;
  final int step;

  OnboardingButton({
    Key key,
    @required this.onClick,
    @required this.step,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
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
            step == 0 ? "Let's get started!" : "Got it, thanks!",
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
