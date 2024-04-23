import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final DocumentReference _characterDocumentReference = FirebaseFirestore.instance.collection('characters').doc('LilliNimWarryn');

  DocumentReference getCharacterReference() {
    return _characterDocumentReference;
  }

  Future readInventory() async {
    try {
      DocumentSnapshot ds = await _characterDocumentReference.collection('Inventory').doc('LQGgXwip2m8O3ByVZKQ4').get();
      Map<String, dynamic> fields = ds.data() as Map<String, dynamic>;
      return fields;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}