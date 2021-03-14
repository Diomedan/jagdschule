import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jagdschule/models/images.dart';
import 'package:jagdschule/models/settings.dart';

import 'package:jagdschule/screens/images.dart';
import 'package:jagdschule/screens/home.dart';
import 'package:jagdschule/screens/info.dart';
import 'package:jagdschule/screens/settings.dart';
import 'package:jagdschule/layout/theme.dart';

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
        title: 'Wildtierarten & Jagdhunde',
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
