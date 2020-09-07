import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                child: SvgPicture.asset('assets/icons/water_track_logo.svg'),
              ),
              SizedBox(height: 40),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                minWidth: 100.0,
                height: 45,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign In with Google',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                  ],
                ),
                onPressed: () {
                  signInWithGoogle().then((User user) {
                    if(user != null) {
                      updateUserData(user);
                      navigatorKey.currentState.pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false);
                      }
                  });
                },
              ),
              SizedBox(height: 25),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                minWidth: 100.0,
                height: 45,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.apple),
                    SizedBox(width: 10),
                    Text('Sign In with Apple',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                  ],
                ),
                onPressed: () async {
                  await signInWithApple();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
