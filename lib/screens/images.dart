import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/images.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/imagesScreen';

  @override
  Widget build(BuildContext context) {
    var imagesList = Provider.of<Images>(context);
    return Consumer<Images>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.pop(context);
            imagesList.showSpecies = false;
          }),
          title: Text(value.animalType),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 2),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                    // TODO: enable zoom-in
                    value.previousItems[value.currentItem][2],
                  ),
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Divider(),
                InkWell(
                    child: Row(
                      children: [Text(value.showSpecies ? value.animalSpecies : "Tierart anzeigen", style: TextStyle(fontSize: 20))],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () {
                      value.showSpecies ? value.showSpecies = false : value.showSpecies = true;
                    }),
                Divider(),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(children: [
              Column(
                children: [
                  if (value.currentItem > 0)
                    Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 0, 0, 14.0),
                        child: InkWell(
                            child: Row(
                              children: [Text("Vorheriges Photo", style: TextStyle(fontSize: 20))],
                            ),
                            onTap: () {
                              imagesList.currentItem -= 1;
                              imagesList.animalSpecies = value.previousItems[value.currentItem][1];
                            }))
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Column(
                children: [VerticalDivider()],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 14.0, 14.0),
                      child: InkWell(
                          child: Row(
                            children: [Text("Nächstes Photo", style: TextStyle(fontSize: 20))],
                          ),
                          onTap: () {
                            imagesList.currentItem += 1; // improve showing the species name: if not shown so far, it will not show when going back or forth
                            value.showSpecies = false;
                            if (imagesList.currentItem == imagesList.previousItems.length) {
                              imagesList.addToPreviousItems(imagesList.speciesSet, imagesList.speciesItems);
                            }
                            value.animalSpecies = value.previousItems[value.currentItem][1];
                          }))
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              )
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    });
  }
}
