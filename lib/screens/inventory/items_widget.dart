import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Text("Boots"),
            Text("50 ft rope"),
            Text("Example"),
            Text("Text"),
          ].map((widget) => Padding(
          padding: const EdgeInsets.all(16),
          child: widget,
          )).toList(),
        ),
      ),
    );
  }
}