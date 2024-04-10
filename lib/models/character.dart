import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Character extends ChangeNotifier{
  int currentHealth = 20;
  int maxHealth = 20;
  
    getHealth() async {
    //var collection = FirebaseFirestore.instance.collection('characters');

    FirebaseFirestore.instance.collection('characters').doc('LilliNimWarryn').get().then((value) {

      //'value' is the instance of 'DocumentSnapshot'
      //'value.data()' contains all the data inside a document in the form of 'dictionary'
      var fields = value.data();
      print(fields?['health']);

    });
  }

  void increaseHealth(int healthDelta){
    currentHealth += healthDelta;
    notifyListeners();
  }

  void decreaseHealth(int healthDelta) {
    currentHealth -= healthDelta;
    notifyListeners();
  }

} 