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
  print('Apple Sign In');

  return null;
}

void signOut() async {
  await _googleSignIn.signOut();

  print("User Sign Out");
}
