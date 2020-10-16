import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';
import 'package:ist_study/style/typography.dart';

ThemeData theme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  primaryColor: blue,
  primaryColorDark: blue,
  scaffoldBackgroundColor: lightGray300,
  canvasColor: Colors.white,
  shadowColor: lightGray300,
  unselectedWidgetColor: slate,
  toggleableActiveColor: blue,
  accentColor: blue,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    color: Colors.white,
    elevation: 1,
    centerTitle: false,
    iconTheme: IconThemeData(color: blue),
    actionsIconTheme: IconThemeData(color: blue),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: dark,
    contentTextStyle: textTheme.bodyText1.copyWith(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: blue,
    unselectedItemColor: dark400,
    selectedLabelStyle: TextStyle(
      color: dark400,
      fontSize: 12.0,
    ),
  ),
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    color: Colors.white,
    margin: EdgeInsets.zero,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: blue,
    shape: StadiumBorder(),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  ),
  dialogTheme: DialogTheme(
    elevation: 1,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: blue,
    foregroundColor: Colors.white,
  ),
);
