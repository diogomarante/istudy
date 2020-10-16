import 'package:flutter/material.dart';
import 'package:ist_study/style/colors.dart';
import 'package:ist_study/style/typography_dark.dart';

ThemeData themeDark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  primaryColor: blue,
  scaffoldBackgroundColor: dark,
  canvasColor: dark600,
  shadowColor: blue,
  unselectedWidgetColor: lightGray300,
  toggleableActiveColor: blue,
  accentColor: blue,
  textTheme: textThemeDark,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: dark600,
    elevation: 1,
    centerTitle: false,
    iconTheme: IconThemeData(color: blue),
    actionsIconTheme: IconThemeData(color: blue),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: dark,
    contentTextStyle: textThemeDark.bodyText1.copyWith(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: blue,
    unselectedItemColor: gray300,
    selectedLabelStyle: TextStyle(
      color: gray300,
      fontSize: 12.0,
    ),
  ),
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    color: dark600,
    margin: EdgeInsets.zero,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: blue,
    shape: StadiumBorder(),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  ),
  dialogTheme: DialogTheme(
    elevation: 1,
    backgroundColor: dark600,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: dark600,
    foregroundColor: blue,
  ),
);
