import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Character extends ChangeNotifier {
  int _currentHealth = 20;
  int _maxHealth = 20;
  
    getHealth() async {
    //var collection = FirebaseFirestore.instance.collection('characters');

    FirebaseFirestore.instance.collection('characters').doc('LilliNimWarryn').get().then((value) {

      //'value' is the instance of 'DocumentSnapshot'
      //'value.data()' contains all the data inside a document in the form of 'dictionary'
      var fields = value.data();
      print(fields?['health']);

    });
  }

  int getCurrentHealth() {
    return _currentHealth;
  }

  int getMaxHealth() {
    return _maxHealth;
  }

  void increaseHealth(int healthDelta){
    _currentHealth += healthDelta;
    notifyListeners();
  }

  void decreaseHealth(int healthDelta) {
    _currentHealth -= healthDelta;
    notifyListeners();
  }

} 