import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    canvasColor: Color.fromRGBO(255, 254, 229, 1),
    bottomAppBarColor: Colors.black,
    fontFamily: 'Raleway',
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          subtitle1: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.pink,
    ).copyWith(
      secondary: Colors.amber,
    ),
  );
}
