

import 'package:flutter/material.dart';

class AppTheme {
  static  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.amber,
      textTheme: TextTheme(
        headline2: TextStyle(
          fontFamily: 'Roboto-Medium'
        ),
        headline1: TextStyle(
            fontFamily: 'Lobster'
        ),
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black54,
      textStyle: TextStyle(
        color: Colors.white,
        fontFamily:'Roboto-Bold'
      ),
    )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.amber)
  );
  static  ThemeData darkTheme = ThemeData();

}