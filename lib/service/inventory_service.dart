import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnd_character_manager/service/firestore_service.dart';
import 'package:flutter/services.dart';

class InventoryService{
  FirestoreService _firestoreService = FirestoreService();
  late DocumentReference inventoryReference;

  InventoryService() {
    inventoryReference = _firestoreService.getCharacterReference().collection('Inventory').doc('LQGgXwip2m8O3ByVZKQ4');
  }
  

  Future readInventory() async {
    try {
      DocumentSnapshot ds = await inventoryReference.get();
      return ds.data() as Map<String, dynamic>;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future update(Map updatedEntery) async {
    //inventoryReference.update(Map.of(updatedEntery));
    print('called inimplended save to db');
  }
}