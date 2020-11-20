import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:ist_study/models/campus.dart';
import 'package:ist_study/screens/main/main_screen.dart';
import 'package:ist_study/style/theme.dart';
import 'package:ist_study/style/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> buildings = List<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tecnico1").snapshots(),
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
        return MaterialApp(
          theme: theme,
          home: new Scaffold(
            body: SafeArea(
                child: MainScreen(
                    campus: Campus(name: "Alameda", buildings: buildings))),
            backgroundColor: softBlue,
          ),
        );
      },
    );
  }
}
