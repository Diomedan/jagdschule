// import 'dart:ui' as ui;
// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jagdschule/models/images.dart';
import 'package:jagdschule/models/pageFlipBuilder.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/imagesScreen';
  final pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    var imagesList = Provider.of<Images>(context);
    return Consumer<Images>(builder: (context, value, child) {
      if (value.previousItems.isEmpty) {
        return Scaffold(
            body: Center(
                child:
                    Text("Navigiere zum Hauptmenü, um die App zu starten.")));
      } else {
        return Scaffold(
          appBar: AppBar(
              leading: BackButton(onPressed: () {
                Navigator.pop(context);
                imagesList.showSpecies = false;
              }),
              title: Text(value.animalType),
              actions: [
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {},
                ),
              ]),
          body: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: PageFlipBuilder(
                  key: pageFlipKey,
                  frontBuilder: (_) => ImageCard(
                    context: context,
                    value: value,
                    child: child,
                    onFlip: () => pageFlipKey.currentState?.flip(),
                  ),
                  backBuilder: (_) => InfoCard(
                    context: context,
                    value: value,
                    child: child,
                    onFlip: () => pageFlipKey.currentState?.flip(),
                  ),
                )),
          ),
        );
      }
    });
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard(
      {Key? key,
      required this.context,
      required this.value,
      required this.child,
      this.onFlip})
      : super(key: key);
  final BuildContext context;
  final Images value;
  final Widget? child;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(fontSize: 20);
    var imagesList = Provider.of<Images>(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          InteractiveViewer(
            child: Container(
              padding: EdgeInsets.all(16),
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
          ),
          Spacer(),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: FittedBox(
                      child: Text(
                    value.showSpecies
                        ? value.animalSpecies
                        : "Tierart anzeigen",
                    style: _textStyle,
                  )),
                  onTap: () {
                    value.showSpecies
                        ? value.showSpecies = false
                        : value.showSpecies = true;
                  },
                ),
              ],
            ),
          ),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: Column(children: [
                  if (value.currentItem > 0)
                    InkWell(
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "Vorheriges Photo",
                            style: _textStyle,
                          )),
                      onTap: () {
                        imagesList.currentItem -= 1;
                        imagesList.animalSpecies =
                            value.previousItems[value.currentItem][1];

                        imagesList
                            .loadSpeciesInfoWidgetList(value.animalSpecies);
                      },
                    )
                ])),
                Expanded(
                    child: IconButton(
                  onPressed: onFlip,
                  icon: const Icon(Icons.flip),
                )),
                Expanded(
                    child: Column(children: [
                  InkWell(
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "Nächstes Photo",
                          style: _textStyle,
                        )),
                    onTap: () {
                      imagesList.currentItem +=
                          1; // improve showing the species name: if not shown so far, it will not show when going back or forth
                      value.showSpecies = false;
                      if (imagesList.currentItem ==
                          imagesList.previousItems.length) {
                        imagesList.addToPreviousItems(
                            imagesList.speciesSet, imagesList.speciesItems);
                      }
                      value.animalSpecies =
                          value.previousItems[value.currentItem][1];

                      imagesList.loadSpeciesInfoWidgetList(value.animalSpecies);
                    },
                  ),
                ]))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.black54,
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard(
      {Key? key,
      required this.context,
      required this.value,
      required this.child,
      this.onFlip})
      : super(key: key);
  final BuildContext context;
  final Images value;
  final Widget? child;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value.animalSpecies),
                Expanded(
                    child: Scrollbar(
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: value.currentSpeciesInfoWidgetList,
                        )),
                  ),
                )),
                // loadInfoText(value.speciesInfoItems, value.animalSpecies)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: onFlip,
                      icon: const Icon(Icons.flip),
                    )
                  ],
                )
              ],
            )));
  }
}
