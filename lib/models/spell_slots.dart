import 'package:flutter/material.dart';

class SpellSlots extends ChangeNotifier {
  List<int> maxSlots = [0, 4, 2];
  List<int> currentSlots = [0, 4, 2];

  void castSpell(int level) {
    currentSlots[level] = currentSlots[level] - 1;
    notifyListeners();
  }

  void restoreSpells() {
    currentSlots = maxSlots;
    notifyListeners();
  }
}