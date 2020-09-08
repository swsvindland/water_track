import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication gsa =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: gsa.idToken,
    accessToken: gsa.accessToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User firebaseUser = authResult.user;

  final User currentUser = _auth.currentUser;
  assert(firebaseUser.uid == currentUser.uid);
  return firebaseUser;
}

Future<User> signInWithApple() async {
  try {

    final AuthorizationResult appleResult = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    if (appleResult.error != null) {
      // handle errors from Apple here
    }

    final AuthCredential credential = OAuthProvider('apple.com').credential(
      accessToken: String.fromCharCodes(appleResult.credential.authorizationCode),
      idToken: String.fromCharCodes(appleResult.credential.identityToken),
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    User user = authResult.user;

    return user;
  } catch (error) {
    print(error);
    return null;
  }
}

void signOut() async {
  await _googleSignIn.signOut();
  await _auth.signOut();
}
