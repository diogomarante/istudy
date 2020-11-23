import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'file:///C:/Users/diogo/OneDrive/Tecnico/2ano/CCU/ist_study/lib/screens/onboarding/components/onboarding_button.dart';
import 'file:///C:/Users/diogo/OneDrive/Tecnico/2ano/CCU/ist_study/lib/screens/onboarding/components/onboarding_navigator.dart';
import 'package:ist_study/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  final Function onFinish;

  OnboardingScreen({
    Key key,
    @required this.onFinish,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  void onNext() {
    this.setState(() {
      currentPage = currentPage + 1;
    });
  }

  void onBack() {
    this.setState(() {
      currentPage = currentPage - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool edgePage =
        pages[currentPage].step == 0 || pages[currentPage].step == 5;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SizedBox()),
              pages[currentPage].image,
              Expanded(child: SizedBox()),
              Text(
                pages[currentPage].title,
                style:
                    Theme.of(context).textTheme.headline1.copyWith(color: blue),
              ),
              SizedBox(height: 10),
              edgePage
                  ? SizedBox(height: 10)
                  : Text("step " + pages[currentPage].step.toString(),
                      style: Theme.of(context).textTheme.headline5),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: pages[currentPage].description,
              ),
              edgePage
                  ? SizedBox()
                  : Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: AnimatedSmoothIndicator(
                          activeIndex: currentPage - 1,
                          count: 4,
                          effect: ColorTransitionEffect(activeDotColor: blue),
                        ),
                      ),
                    ),
              Expanded(child: SizedBox()),
              edgePage
                  ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: OnboardingButton(
                          step: pages[currentPage].step,
                          onClick: pages[currentPage].step == 0
                              ? onNext
                              : widget.onFinish,
                        ),
                      ),
                    )
                  : OnboardingNavigator(
                      onNext: onNext,
                      onBack: onBack,
                      step: pages[currentPage].step),
              SizedBox(height: edgePage ? 50 : 30),
            ],
          ),
        ),
      ],
    );
  }
}

List<Page> pages = [
  Page(
    image: SvgPicture.asset(
      "assets/images/studying.svg",
      height: 200,
    ),
    title: "Welcome to ISTudy",
    description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            children: [
              TextSpan(text: "This is a quick guide to get you ready."),
            ])),
    step: 0,
  ),
  Page(
    image: SvgPicture.asset(
      "assets/images/login.svg",
      height: 250,
    ),
    title: "Sign in",
    description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                  text: "Use your IST credentials to login through Fénix."),
            ])),
    step: 1,
  ),
  Page(
    image: Container(
      height: 250.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/choose_a_place.PNG'),
          fit: BoxFit.fitHeight,
        ),
      ),
    ),
    title: "Choose a place",
    description: Column(
      children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(
                      text:
                          "Select search for the building and room that you want to study."),
                ])),
        SizedBox(height: 20),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(
                      text:
                          "You can see how many tables are available in each room. "),
                ])),
      ],
    ),
    step: 2,
  ),
  Page(
    image: Container(
      height: 250.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/choose_a_table.PNG'),
          fit: BoxFit.fitHeight,
        ),
      ),
    ),
    title: "Choose a table",
    description: Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              children: [
                TextSpan(text: "Tables can be "),
                TextSpan(
                    text: "available and cleaned ",
                    style: TextStyle(color: cleanedColor)),
                TextSpan(
                  text: ", ",
                ),
                TextSpan(
                    text: "not cleaned ", style: TextStyle(color: dirtyColor)),
                TextSpan(
                  text: "and ",
                ),
                TextSpan(
                    text: "occupied", style: TextStyle(color: occupiedColor)),
                TextSpan(
                  text: ".",
                ),
              ]),
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Text(
              "Some tables also have a",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "computer",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              SvgPicture.asset(
                "assets/images/personal-computer.svg",
                height: 40,
                color: blue,
              ),
              SizedBox(width: 10),
              Text(
                "available.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ])
          ],
        )
      ],
    ),
    step: 3,
  ),
  Page(
    image: Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/scan.PNG'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    ),
    title: "Check-in",
    description: Column(
      children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: "When your table is "),
                  TextSpan(
                      text: "ready", style: TextStyle(color: cleanedColor)),
                  TextSpan(
                      text:
                          ", scan the QR code on the table and you are good to go."),
                ])),
        SizedBox(height: 20),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(text: "You will have "),
                  TextSpan(
                      text: "15 minutes ",
                      style: TextStyle(color: Colors.orange)),
                  TextSpan(text: "to scan the QR code once your table is "),
                  TextSpan(text: "."),
                ])),
      ],
    ),
    step: 4,
  ),
  Page(
    image: SvgPicture.asset(
      "assets/images/studying.svg",
      height: 200,
    ),
    title: "One last thing...",
    description: Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                    text:
                        "You may extend your session up to 3 hours when there are  "),
                TextSpan(
                    text: "30 minutes ",
                    style: TextStyle(color: Colors.orange)),
                TextSpan(
                  text: "left on the timer.",
                ),
              ]),
        ),
        SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              children: [
                TextSpan(text: "Please don’t forget to  "),
                TextSpan(
                    text: "check-out ", style: TextStyle(color: Colors.orange)),
                TextSpan(
                  text: "if you need to leave earlier.",
                ),
              ]),
        ),
      ],
    ),
    step: 5,
  ),
];

class Page {
  Widget image;
  String title;
  Widget description;
  int step;
  Page(
      {@required this.image,
      @required this.title,
      @required this.description,
      @required this.step});
}
