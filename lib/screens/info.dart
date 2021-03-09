import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoText {
  Future<String> readCounter() async {
    // Read the file
    String contents = await rootBundle.loadString("assets/info.txt");

    return contents;
  }
}

class InfoScreen extends StatefulWidget {
  final InfoText infoText;
  static String routeName = '/infoScreen';

  InfoScreen({Key key, @required this.infoText}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _infoText;

  @override
  void initState() {
    super.initState();
    widget.infoText.readCounter().then((String value) {
      setState(() {
        _infoText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text(_infoText),
      ),
    );
  }
}
