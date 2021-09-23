import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final materialTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color.fromRGBO(2, 42, 70, 1),
    primaryColor: Color.fromRGBO(2, 42, 70, 1),
    errorColor: Colors.red,
    fontFamily: 'RobotoMono',
    textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
            // for button text
            fontFamily: 'RobotoMono',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline3: TextStyle(
            // Textfield Text
            fontFamily: 'RobotoMono',
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 18,
            color: Colors.white,
          ),
          headline5: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 18,
            color: Color.fromRGBO(2, 42, 70, 1),
          ),
          headline6: TextStyle(
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1.2,
            color: Color.fromRGBO(2, 42, 70, 1),
          ),
          subtitle1: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          subtitle2: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      labelStyle: TextStyle(
          color: Color.fromRGBO(2, 42, 70, 1),
          fontSize: 17,
          fontWeight: FontWeight.w400),
      hintStyle: TextStyle(
          color: Color.fromRGBO(2, 42, 70, 1),
          fontSize: 17,
          fontWeight: FontWeight.w400),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.green),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.black38),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(2, 42, 70, 1),
      titleTextStyle: TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final cupertinoTheme = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    primaryContrastingColor: Color.fromRGBO(2, 42, 70, 1),
    primaryColor: Color.fromRGBO(2, 42, 70, 1),
    barBackgroundColor: Colors.red,
  );
}
