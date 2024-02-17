import 'package:flutter/material.dart';

class SpellbookWidget extends StatefulWidget {
  const SpellbookWidget({super.key});

  @override
  State<SpellbookWidget> createState() => _SpellbookWidgetState();
}

class _SpellbookWidgetState extends State<SpellbookWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Spellbook',
          ),
        ],
      ),
    );
  }
}