import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testing_app/models/images.dart';
import 'package:testing_app/models/settings.dart';

import 'package:testing_app/screens/images.dart';
import 'package:testing_app/screens/home.dart';
import 'package:testing_app/screens/info.dart';
import 'package:testing_app/screens/settings.dart';
import 'package:testing_app/layout/theme.dart';

void main() {
  runApp(JagdLernApp());
}

class JagdLernApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Images>(create: (context) => Images()),
        ChangeNotifierProvider<Settings>(create: (context) => Settings()),
      ],
      child: MaterialApp(
        title: 'Testing Sample',
        theme: CustomAppTheme.customAppTheme(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ImageScreen.routeName: (context) => ImageScreen(),
          InfoScreen.routeName: (context) => InfoScreen(infoText: InfoText()),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
