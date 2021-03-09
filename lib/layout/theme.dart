import 'package:flutter/material.dart';

class CustomAppTheme {
  static ThemeData customAppTheme() {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.lightGreen[800],
      accentColor: Colors.green[400],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
    );
  }
}
