import 'package:dnd_character_manager/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Character extends ChangeNotifier {
  FirestoreService _firestoreService = FirestoreService();
  late DocumentReference characterReference = _firestoreService.getCharacterReference();

  
  int _currentHealth = 20;
  int _maxHealth = 20;
  
    getHealth() async {
    DocumentSnapshot ds = await characterReference.get();
    _currentHealth = ds.get('currentHealth');
    _maxHealth = ds.get('maxHealth');
    notifyListeners();
  }

  int getCurrentHealth() {
    return _currentHealth;
  }

  int getMaxHealth() {
    return _maxHealth;
  }

  void increaseHealth(int healthDelta){
    _currentHealth += healthDelta;
    characterReference.update({'currentHealth' : _currentHealth});
    notifyListeners();
  }

  void decreaseHealth(int healthDelta) {
    _currentHealth -= healthDelta;
    characterReference.update({'currentHealth' : _currentHealth});
    notifyListeners();
  }

  void restoreHelath() {
    _currentHealth = _maxHealth;
    characterReference.update({'currentHealth' : _currentHealth});
    notifyListeners();
  }

} 