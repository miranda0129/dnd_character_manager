import 'package:flutter/material.dart';

class GoldWidget extends StatefulWidget {
  const GoldWidget({super.key});

  @override
  State<GoldWidget> createState() => _GoldWidgetState();
}

class _GoldWidgetState extends State<GoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text("Plat"),
            Text("Gold"),
            Text("Silver"),
            Text("Copper"),
          ].map((widget) => Padding(
          padding: const EdgeInsets.all(16),
          child: widget,
          )).toList(),
        ),
      ),
    );
  }
}