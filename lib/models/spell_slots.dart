import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpellSlots extends ChangeNotifier {
  List<int> maxSlots = [0, 4, 3];
  List<int> currentSlots = [0, 4, 3];

  SpellSlots() {
    readCurrentSlots();
  }

  void castSpell(int level) {
    currentSlots[level] = currentSlots[level] - 1;
    update(level, currentSlots[level]);
    notifyListeners();
  }

  void restoreSpells() {
    currentSlots = List.from(maxSlots);
    notifyListeners();
  }

  void update(int level, int slots) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(level.toString(), slots);
  }

  void readCurrentSlots() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 1 ; i<currentSlots.length; i++) {
      if (prefs.containsKey(i.toString())) {
          currentSlots[i] = prefs.getInt(i.toString())!;
      }
    }
    notifyListeners();
  }

  void restoreSlots() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 1 ; i<maxSlots.length; i++) {
      if (prefs.containsKey(i.toString())) {
          prefs.remove(i.toString());
      }
    }
    restoreSpells();
  }
}