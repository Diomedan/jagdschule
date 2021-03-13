import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class Settings extends ChangeNotifier {
  final List<List<dynamic>> _speciesSettings = [];

  List<List<dynamic>> get speciesSettings => _speciesSettings;
}
