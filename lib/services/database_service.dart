import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_track/models/models.dart';
import 'dart:async';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Drinks> streamDrinks(String id) {
    try {
      return _db
          .collection('drinks')
          .doc(id)
          .collection('days')
          .doc('${date.year}${date.month}${date.day}')
          .snapshots()
          .map((snap) => Drinks.fromMap(snap.data()!));
    } catch (err) {
      print(err);
      return Stream.error(err);
    }
  }

  Future<void> updateDrinks(String id, Drinks drinks) {
    try {
      return _db
          .collection('drinks')
          .doc(id)
          .collection('days')
          .doc('${date.year}${date.month}${date.day}')
          .set(Drinks.toMap(drinks));
    } catch (err) {
      print(err);
      return Future.error(err);
    }
  }

  Stream<Preferences> streamPreferences(String id) {
    try {
      return _db
          .collection('preferences')
          .doc(id)
          .snapshots()
          .map((snap) => Preferences.fromMap(snap.data()!));
    } catch (err) {
      print(err);
      return Stream.error(err);
    }
  }

  Future<void> updatePreferences(String id, Preferences preferences) {
    try {
      return _db
          .collection('preferences')
          .doc(id)
          .set(Preferences.toMap(preferences));
    } catch (err) {
      print(err);
      return Future.error(err);
    }
  }
}
