import 'package:flutter/material.dart';
import 'main.dart';

class AboutPage extends StatefulWidget {
  final CardInfo cardInfo;

  const AboutPage({Key? key, required this.cardInfo}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late TextEditingController controller;
  late CardInfo cardInfo2;
  bool textFieldModified = false;

  @override
  void initState() {
    cardInfo2 = CardInfo(
      id: widget.cardInfo.id,
      title: widget.cardInfo.title,
      imageUrl: widget.cardInfo.imageUrl,
    );
    controller = TextEditingController(text: cardInfo2.title);

    super.initState();
  }

  void save() {
    cardInfo2.title = controller.text;
  }

  Future<bool?> showDiscardChangesDialog() async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Attention!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: const Text('Continue without change?'),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green[700],
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      save();
                      Navigator.of(context).pop(true);
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red[700],
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (textFieldModified) {
          bool? discardChanges = await showDiscardChangesDialog();
          if (discardChanges ?? false) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('HW_FLUTTER_2')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      widget.cardInfo.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          textFieldModified = true;
                        });
                      },
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      maxLines: 2,
                      maxLength: 35,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    save();
                    Navigator.of(context).pop(cardInfo2);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
