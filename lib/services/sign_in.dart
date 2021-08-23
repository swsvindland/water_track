import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

Future<User?> signInWithApple() async {
  try {
    final AuthorizationResult appleResult = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    if (appleResult.error != null) {
      // handle errors from Apple here
    }

    final AuthCredential credential = OAuthProvider('apple.com').credential(
      accessToken: appleResult.credential?.authorizationCode?.toString(),
      idToken: appleResult.credential?.identityToken?.toString(),
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    User? user = authResult.user;

    return user;
  } catch (error) {
    print(error);
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
