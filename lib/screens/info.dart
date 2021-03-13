import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoText {}

class InfoScreen extends StatefulWidget {
  static String routeName = '/infoScreen';

  InfoScreen({Key key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var _infoText;

  Future<String> readInfoText() async {
    // Read the file
    final contents = await rootBundle.loadString("info.txt");
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(child: Text("test")),
    );
  }
}
