import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_track/models/preferences.dart';

void createDefaultPreferences(FirebaseFirestore db, User user) async {
  DocumentSnapshot snapshot = await db.collection('preferences').doc(user.uid).get();

  if(!snapshot.exists) {
    snapshot.reference.set({
      'unit': Unit.imperial.value,
      'waterGoal': 96,
      'totalGoal': 128,
      'drinkSize': 8
    });
  }
}

void updateUserData(FirebaseFirestore db, User user) async {
  DocumentReference ref = db.collection('users').doc(user.uid);

  return ref.set({
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'lastSeen': DateTime.now()
  });
}