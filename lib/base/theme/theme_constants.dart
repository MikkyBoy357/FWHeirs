import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.deepOrangeAccent;
const COLOR_ACCENT = Colors.orange;

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  secondaryHeaderColor: Colors.white,
  cardColor: Colors.black,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.black,
      // fontFamily: Constant.fontsFamily,
      fontFamily: "",
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      color: Colors.black,
      // fontFamily: Constant.fontsFamily,
      fontFamily: "",
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: COLOR_ACCENT),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
      backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.grey[900],
  secondaryHeaderColor: Colors.grey[900],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.white,
      // fontFamily: Constant.fontsFamily,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontStyle: FontStyle.normal,
      color: Colors.white,
      // fontFamily: Constant.fontsFamily,
      fontWeight: FontWeight.w500,
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
);
