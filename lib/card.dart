import 'package:flutter/material.dart';
import 'package:hw_flutter_2/main.dart';

class CustomCard extends StatelessWidget {
  final CardInfo cardInfo;
  final VoidCallback onTap;

  const CustomCard({
    Key? key,
    required this.cardInfo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Positioned(
      top: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, right: 4, left: 16),
              child: _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildButtonColumn(Colors.green, Icons.near_me, 'ROUTE'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 16),
              child: _buildButtonColumn(Colors.black87, Icons.share, 'SHARE'),
            ),
          ],
        ),
      ),
    );

    return Stack(
      children: [
        Image.asset(
          cardInfo.imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.black54,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cardInfo.title,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        buttonSection,
        Positioned(
          left: 16,
          top: 16,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(64)),
                color: Colors.black87,
              ),
              child: Center(
                child: Text(
                  '#${cardInfo.id}.',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
