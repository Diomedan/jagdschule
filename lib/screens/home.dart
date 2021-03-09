import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import 'package:testing_app/models/images.dart';
import 'package:testing_app/screens/images.dart';
// import 'package:testing_app/screens/info.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tierarten lernen'), actions: [
        IconButton(icon: Icon(Icons.info), onPressed: () {} // Navigator.pushNamed(context, InfoScreen.routeName))       überarbeiten bevor das aktiviert werden kann
            )
      ]),
      body: ListView.builder(
        itemCount: 3,
        cacheExtent: 20.0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) => ItemTile(index),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  static const _animalTypes = [
    'Federwild',
    'Haarwild',
    'Jagdhunde',
  ];

  Future<List<List<dynamic>>> loadCsv(animalType) async {
    final csvData = await rootBundle.loadString("assets/images.csv");
    List<List<dynamic>> csvTable = CsvToListConverter(eol: ';').convert(csvData);
    var animalExclusiveCsvTable = [
      for (var e in csvTable)
        if (e[0].contains(animalType)) e
    ];

    return animalExclusiveCsvTable;
  }

  Future<Set> createSpeciesSet(animalType) async {
    final csvData = await rootBundle.loadString("assets/images.csv");
    List<List<dynamic>> csvTable = CsvToListConverter(eol: ';').convert(csvData);
    var animalExclusiveCsvTable = [
      for (var e in csvTable)
        if (e[0].contains(animalType)) e
    ];
    return Set.from([for (var e in animalExclusiveCsvTable) e[1]]);
  }

  @override
  Widget build(BuildContext context) {
    var imagesList = Provider.of<Images>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(_animalTypes[itemNo], key: Key(_animalTypes[itemNo]), style: TextStyle(fontSize: 20)),
        onTap: () async {
          imagesList.currentItem = 0;
          imagesList.speciesSet.clear();
          imagesList.previousItems.clear();
          imagesList.speciesItems.clear();
          var animalType = _animalTypes[itemNo];
          var animalTypeCsv = await loadCsv(animalType);
          var speciesSet = await createSpeciesSet(animalType);
          imagesList.animalType = animalType;
          imagesList.add(animalTypeCsv);
          imagesList.addSpeciesSet(speciesSet);
          imagesList.addToPreviousItems(speciesSet, animalTypeCsv);
          imagesList.animalSpecies = imagesList.previousItems[0][1];
          Navigator.pushNamed(context, ImageScreen.routeName);
        },
      ),
    );
  }
}
