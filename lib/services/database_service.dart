import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_track/models/drink.dart';
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  /// Get a stream of a single document
  Stream<Drinks> streamDrinks(String id) {
    return _db
        .collection('drinks')
        .doc(id)
        .collection('days')
        .doc('${date.year}${date.month}${date.day}')
        .snapshots()
        .map((snap) => Drinks.fromMap(snap.data()));
  }

  /// Write data
  Future<void> updateDrinks(String id, Drinks drinks) {
    return _db
        .collection('drinks')
        .doc(id)
        .collection('days')
        .doc('${date.year}${date.month}${date.day}')
        .set(Drinks.toMap(drinks));
  }
}
