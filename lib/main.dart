import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ist_study/models/fenix_user.dart';
import 'package:ist_study/screens/main/components/confirm_exit.dart';
import 'package:uni_links/uni_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:ist_study/models/campus.dart';
import 'package:ist_study/screens/main/main_screen.dart';
import 'package:ist_study/screens/onboarding/onboarding_screen.dart';
import 'package:ist_study/services/fenix_service.dart';
import 'package:ist_study/style/theme.dart';
import 'package:ist_study/style/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/studying.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/images/books.svg'),
      null);
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FenixUser user;
  List<Map<String, dynamic>> buildings = List<Map<String, dynamic>>();
  FenixService fenix = FenixService();
  StreamSubscription _uniLinksSubscription;
  Future<String> fenixToken;
  bool seenOnboarding = false;
  bool ready = false;
  Timer timer;

  int currentStep = 0;
  String currentPage = "home";

  @override
  void initState() {
    super.initState();
    checkLogin();
    startListener();
    precacheImage(AssetImage('assets/images/choose_a_place.PNG'), context);
    timer = Timer(
        Duration(seconds: 2),
        () => setState(() {
              ready = true;
            }));
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) timer.cancel();
    if (_uniLinksSubscription != null) _uniLinksSubscription.cancel();
  }

  startListener() async {
    _uniLinksSubscription = getUriLinksStream().listen((Uri uri) async {
      String code = uri.queryParameters['code'];
      if (code != null) {
        String fenixToken = await fenix.fetchAccessToken(code);
        setState(() {
          seenOnboarding = true;
          setUser(fenixToken);
        });
      }
    });
  }

  setUser(String token) async {
    user = await fenix.fetchPerson(token);
    setState(() {
      seenOnboarding = true;
    });
  }

  checkLogin() async {
    final storage = new FlutterSecureStorage();

    String loggedIn = await storage.read(key: "logged_in");
    if (loggedIn == "true") {
      String token = await storage.read(key: "access_token");
      user = await fenix.fetchPerson(token);

      if (mounted) {
        setUser(token);
      } else {
        user = await fenix.fetchPerson(token);
      }
    }
  }

  onFinishOnboarding() {
    this.setState(() {
      currentStep = 0;
    });
    fenix.loginIn();
  }

  onLogout() {
    final storage = new FlutterSecureStorage();
    this.setState(() {
      seenOnboarding = false;
      user = null;
    });
    storage.write(key: 'logged_in', value: "false");
  }

  void onNext() {
    this.setState(() {
      currentStep = currentStep + 1;
    });
  }

  void onBack() {
    this.setState(() {
      currentStep = currentStep - 1;
    });
  }

  void togglePage({String page}) {
    if (page != null) {
      this.setState(() {
        currentPage = page;
      });
    } else {
      this.setState(() {
        currentPage = currentPage == "home" ? "reservation" : "home";
      });
    }
  }

  Future<bool> showExitDialog() async {
    print("sup");
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmExit();
        });
  }

  Future<bool> backPressed() async {
    if (seenOnboarding ?? false) {
      if (user != null && currentPage != "home") {
        togglePage(page: "home");
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    } else {
      if (user == null && currentStep != 0) {
        onBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }
    //Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tecnico4").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        buildings = List<Map<String, dynamic>>();
        for (var building in snapshot.data.docs) {
          buildings.add(building.data());
        }
        return WillPopScope(
          onWillPop: backPressed,
          child: MaterialApp(
            theme: theme,
            home: new Scaffold(
              body: SafeArea(
                child: !ready
                    ? Center(child: CircularProgressIndicator())
                    : seenOnboarding ?? false
                        ? user != null
                            ? MainScreen(
                                campus: Campus(
                                  name: "Alameda",
                                  buildings: buildings,
                                  user: user,
                                ),
                                onLogout: onLogout,
                                user: user,
                                currentPage: currentPage,
                                onTogglePage: togglePage,
                              )
                            : Center(child: CircularProgressIndicator())
                        : OnboardingScreen(
                            onFinish: onFinishOnboarding,
                            currentStep: currentStep,
                            onBack: onBack,
                            onNext: onNext,
                          ),
              ),
              backgroundColor: backgroundColor,
            ),
          ),
        );
      },
    );
  }
}
