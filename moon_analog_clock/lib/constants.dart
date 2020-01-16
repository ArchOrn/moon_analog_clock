import 'package:flutter/material.dart';

class Constants {
  static const STROKE_RATIO = 0.07;
  static const ZOOM_SCALE = 4.0;
  static const MOON_SIZE = 25.0;

  static final defaultTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 25,
    color: Color(0x48000000),
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      display1: defaultTextStyle,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      display1: defaultTextStyle.copyWith(color: Color(0x48f3f3f3)),
    ),
  );
}
