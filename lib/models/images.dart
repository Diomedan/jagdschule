import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class Images extends ChangeNotifier {
  final List<List<dynamic>> _speciesImageItems = [];
  final List<List<dynamic>> _previousImageItems = [];
  /*final List<CachedNetworkImage> _cachedImages = [
    CachedNetworkImage(
      imageUrl: 'https://live.staticflickr.com/1788/43221528202_a5749811b0_o.jpg',
      placeholder: (context, url) => CircularProgressIndicator(),
    )
  ];*/
  var _speciesSet = Set();
  var _animalSpecies = "";
  var _currentItem = 0;
  var _animalType = "";
  var _showSpecies = false;

  List<List<dynamic>> get speciesItems => _speciesImageItems;
  List<List<dynamic>> get previousItems => _previousImageItems;
  Set get speciesSet => _speciesSet;
  String get animalSpecies => _animalSpecies;
  int get currentItem => _currentItem;
  String get animalType => _animalType;
  bool get showSpecies => _showSpecies;
  // List<CachedNetworkImage> get cachedImages => _cachedImages;

  set animalSpecies(currentSpecies) {
    _animalSpecies = currentSpecies;
    notifyListeners();
  }

  set currentItem(currentItem) {
    _currentItem = currentItem;
    notifyListeners();
  }

  set animalType(animalType) {
    _animalType = animalType;
    notifyListeners();
  }

  set showSpecies(showSpecies) {
    _showSpecies = showSpecies;
    notifyListeners();
  }

/*  void addCachedImages(List<String> imageUrls) {
    for (int i = 0; i < imageUrls.length; i++) {
      var imageToCache = CachedNetworkImage(imageUrl: imageUrls[i]);
      _cachedImages.add(imageToCache);
    }
  }
*/
  void add(List<List<dynamic>> speciesCsv) {
    for (final e in speciesCsv) {
      _speciesImageItems.add(e);
      notifyListeners();
    }
  }

  void remove(List<List<dynamic>> speciesCsv) {
    for (final e in speciesCsv) {
      _speciesImageItems.remove(e);
      notifyListeners();
    }
  }

  void addToPreviousItems(Set speciesSet, List<List<dynamic>> speciesCsv) {
    var randomAnimal = speciesSet.elementAt(Random().nextInt(speciesSet.length));

    var speciesImageList = [
      for (var e in speciesCsv)
        if (e[1].contains(randomAnimal)) e
    ];
    _previousImageItems.add(speciesImageList.elementAt(Random().nextInt(speciesImageList.length)));
    notifyListeners();
  }

  void addSpeciesSet(Set speciesSet) {
    _speciesSet = speciesSet;
  }

  void removeSpeciesSet() {
    _speciesSet.clear();
  }
}
