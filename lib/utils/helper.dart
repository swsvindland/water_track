import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void setFCMData(
  FirebaseFirestore db,
  FirebaseMessaging fcm,
  User user,
) async {
  String? fcmToken = await fcm.getToken();

  if (fcmToken != null) {
    var tokenRef = db.collection('tokens').doc(user.uid);
    tokenRef.set({
      'created': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
      'token': fcmToken
    });
  }
}

void createDefaultPreferences(FirebaseFirestore db, User user) async {
  DocumentSnapshot snapshot =
      await db.collection('preferences').doc(user.uid).get();

  if (!snapshot.exists) {
    snapshot.reference.set({
      'unit': 'imperial',
      'waterGoal': 96,
      'totalGoal': 128,
      'drinkSize': 8,
      'start':
          DateTime.parse('2000-01-01 ${7.toString().padLeft(2, '0')}:00:00'),
      'end':
          DateTime.parse('2000-01-01 ${20.toString().padLeft(2, '0')}:00:00'),
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
