import 'package:flutter/material.dart';

class CustomAppTheme {
  static ThemeData customAppTheme() {
    return ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightGreen[800],
        accentColor: Colors.green[400],

        // Define the default font family.
        fontFamily: 'NotoSerif',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.

        // Define the default ElevatedButtonTheme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(22)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            textStyle: MaterialStateProperty.all(
                TextStyle(fontFamily: 'NotoSerif', fontSize: 20)),
          ),
        ),

        // Define the default Theme for the Cards
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            side: BorderSide(
              color: Colors.black54,
            ),
          ),
        ));
  }
}
