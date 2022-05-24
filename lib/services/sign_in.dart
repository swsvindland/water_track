import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount =
      (await _googleSignIn.signIn())!;
  final GoogleSignInAuthentication gsa =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: gsa.idToken,
    accessToken: gsa.accessToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? firebaseUser = authResult.user;

  final User? currentUser = _auth.currentUser;
  assert(firebaseUser?.uid == currentUser?.uid);
  return firebaseUser;
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<User?> signInWithApple() async {
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  try {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final authResult =
    await _auth.signInWithCredential(oauthCredential);

    final firebaseUser = authResult.user;

    return firebaseUser;
  } catch (error) {
    return null;
  }
}

Future<User?> signInAnon() async {
  UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();

  final User? firebaseUser = userCredential.user;

  final User? currentUser = _auth.currentUser;
  assert(firebaseUser?.uid == currentUser?.uid);
  return firebaseUser;
}

void signOut() async {
  await _googleSignIn.signOut();
  await _auth.signOut();
}
