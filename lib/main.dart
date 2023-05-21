import 'package:flutter/material.dart';
import 'package:hw_flutter_2/card.dart';
import 'about.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<CardInfo> _listOfCards = [];

  @override
  void initState() {
    generateCardInfo();
    super.initState();
  }

  void generateCardInfo() {
    for (int i = 0; i < 15; i++) {
      _listOfCards.add(CardInfo(
        title: 'title$i',
        id: i,
      ));
    }
  }

  void updateCard(CardInfo newCardInfo) {
    setState(() {
      _listOfCards[newCardInfo.id] = newCardInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW_FLUTTER_2',
      home: Scaffold(
        //appBar: AppBar(title: const Text('HW_FLUTTER_2')),
        body: ListView.builder(
          itemCount: _listOfCards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                cardInfo: _listOfCards[index],
                onTap: () async {
                  final newCardInfo = await Navigator.push<CardInfo>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AboutPage(
                        cardInfo: _listOfCards[index],
                      ),
                    ),
                  );

                  if (newCardInfo != null) {
                    updateCard(newCardInfo);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CardInfo {
  String title;
  final int id;
  final String imageUrl;

  CardInfo({
    required this.title,
    required this.id,
    this.imageUrl = 'images/lake.jpg',
  });
}
