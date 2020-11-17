import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';



void main() {
  runApp(MyApp());
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Map<String, dynamic>> buildings = List<Map<String, dynamic>>();

  Future<List<DocumentSnapshot>> getData() async {
    await Firebase.initializeApp();
    QuerySnapshot querySnapshot = await Firestore.instance.collection("tecnico1").getDocuments();
    return  querySnapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {

        // Check for errors
        if (snapshot.hasError) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.red,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          for( var building in snapshot.data) {
            buildings.add(building.data());
          }
          return Container(
            height: 100,
            width: 100,
            color: Colors.yellow,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          height: 100,
          width: 100,
          color: Colors.teal,
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: theme,
  //     home: new Scaffold(
  //       body: GestureDetector(
  //         onTap: _signInWithGoogle,
  //         child: MainScreen(),
  //       ),
  //       backgroundColor: softBlue,
  //     ),
  //   );
  // }

  // _signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  //   final User user =
  //       (await firebaseAuth.signInWithCredential(credential)).user;
  //   addData();
  // }
}
