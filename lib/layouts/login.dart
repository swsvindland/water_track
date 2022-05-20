import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:os_detect/os_detect.dart" as Platform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:water_track/utils/helper.dart';
import 'package:water_track/widgets/buttons/button.dart';

class LoginPage extends StatefulWidget {
  LoginPage() : super();

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late bool loggingIn;

  @override
  initState() {
    super.initState();
    setState(() {
      loggingIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.local_drink, size: 96.0, color: Colors.white),
                SizedBox(height: 40),
                loggingIn
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Button(
                            onPressed: () {
                              setState(() {
                                loggingIn = true;
                              });
                              signInWithGoogle().then((User? user) {
                                if (user != null) {
                                  updateUserData(_db, user);
                                  createDefaultPreferences(_db, user);
                                  setFCMData(_db, _fcm, user);
                                  navigatorKey.currentState!
                                      .pushNamedAndRemoveUntil('/home',
                                          (Route<dynamic> route) => false);
                                }
                              });
                              setState(() {
                                loggingIn = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('images/google-logo.png',
                                    width: 24, height: 24),
                                SizedBox(width: 8),
                                Text(AppLocalizations.of(context)!.googleSignIn,
                                    style: new TextStyle(
                                        fontSize: 16.0, color: Colors.black)),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Platform.isIOS
                              ? Button(
                                  onPressed: () {
                                    setState(() {
                                      loggingIn = true;
                                    });
                                    signInWithApple().then((User? user) {
                                      if (user != null) {
                                        updateUserData(_db, user);
                                        createDefaultPreferences(_db, user);
                                        setFCMData(_db, _fcm, user);
                                        navigatorKey.currentState!
                                            .pushNamedAndRemoveUntil(
                                                '/home',
                                                (Route<dynamic> route) =>
                                                    false);
                                      }
                                    });
                                    setState(() {
                                      loggingIn = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.apple),
                                      SizedBox(width: 8),
                                      Text(AppLocalizations.of(context)!.appleSignIn,
                                          style: new TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black)),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(height: Platform.isIOS ? 16 : 0),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  loggingIn = true;
                                });
                                signInAnon().then((User? user) {
                                  if (user != null) {
                                    updateUserData(_db, user);
                                    createDefaultPreferences(_db, user);
                                    setFCMData(_db, _fcm, user);
                                    navigatorKey.currentState!
                                        .pushNamedAndRemoveUntil('/home',
                                            (Route<dynamic> route) => false);
                                  }
                                });
                                setState(() {
                                  loggingIn = false;
                                });
                              },
                              child: Text(AppLocalizations.of(context)!.anonSignIn,
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.white))),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
