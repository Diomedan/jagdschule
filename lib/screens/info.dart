import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoText {
  Future<String> readInfoText() async {
    // Read the file
    String contents = await rootBundle.loadString("assets/info.txt");

    return contents;
  }
}

class InfoScreen extends StatefulWidget {
  final InfoText infoText;
  static String routeName = '/infoScreen';

  InfoScreen({Key? key, required this.infoText}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final _infoText;

  @override
  void initState() {
    super.initState();
    widget.infoText.readInfoText().then((String value) {
      setState(() {
        _infoText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Information')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(text: '''# Tierarten lernen für die Jagdschule

Eine zufällige Auswahl von tausenden aus Flickr geladenen Bildern, um die für den Jagdschein relevanten Wildtier- und Jagdhundearten erkennen zu können. 

## Nutzung der App

Die Bedienung der App ist simpel: einfach die Kategorie aussuchen, die du lernen willst. Dann wird dir ein Bild einer zufälligen Tierart der Kategorie angezeigt. Mit einem Klick auf "Tierart anzeigen" bekommst du zu sehen, um was für ein Tier es sich handelt. Weiterhin kannst du untendrunter ein Bild vor- oder zurück gehen. 

## Mithelfen

Die App ist zwar jetzt schon sinnvoll zum Lernen zu verwenden, aber sie hat noch einiges an Potenzial, die App besser zu machen. Gerne kannst du mir Vorschläge zur Verbesserung der App schicken, Ideen für neue Features vorschlagen oder auf Bugs der App hinweisen. Per WhatsApp, oder auch per Mail: alwin.fassbender@gmail.com

Um weitere Bilder zur App hinzuzufügen, kannst du mir eine .txt oder .csv Datei schicken, die Links zu einem Photo beinhaltet. Die Zeilen der Datei sollten folgendes Format haben: 

Kategorie,Tierart,<"Link zu dem Photo">;
Federwild,Türkentaube,https://live.staticflickr.com/1788/43221528202_a5749811b0_o.jpg; <- wobei auch andere Websiten als Flickr möglich sind!

## Geplante Funktionen

- Da die Bilder alle in Echtzeit aus dem Internet geladen werden, muss je nach Internetverbindung ein paar Sekunden pro Bild gewartet werden. Um das zu verhindern soll Caching eingeführt werden, damit ohne Ladezeiten vor- und zurückgegangen werden kann.
- Zu jeder Tierart soll eine kurze Beschreibung angezeigt werden können, die die wichtigsten Punkte unserer Unterlagen zusammenfasst. 
- Die Bilder sollen herangezoomt werden können.

## Bekannte Fehler

- Manche Bilder werden falsch geclipt und daher ist nur ein Ausschnitt davon zu sehen
- Keine Gewähr für die Korrektheit der Tierart, bisher wurden nicht alle Bilder geprüft. 
''')
            ]),
          ),
        ),
      ),
    );
  }
}
