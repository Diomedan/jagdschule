import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jagdschule/models/settings.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settingsScreen';

  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<Settings>(context);
    return Consumer<Settings>(builder: (context, value, child) {
      return Scaffold(
          body: Center(child: Text("Settings to be displayed here")));
    });
  }
}
