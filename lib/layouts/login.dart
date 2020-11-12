import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' show Platform;

import 'package:water_track/utils/helper.dart';

class LoginPage extends StatefulWidget {
  final Widget child;

  LoginPage({Key key, this.child}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  bool loggingIn;

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
              Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => loggingIn,
                widgetBuilder: (BuildContext context) =>
                    CircularProgressIndicator(),
                fallbackBuilder: (BuildContext context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                          Text('Continue with Google',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          loggingIn = true;
                        });
                        signInWithGoogle().then((User user) {
                          if (user != null) {
                            updateUserData(_db, user);
                            createDefaultPreferences(_db, user);
                            setFCMData(_db, _fcm, user);
                            navigatorKey.currentState.pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          }
                        });
                        setState(() {
                          loggingIn = false;
                        });
                      },
                    ),
                    SizedBox(height: 25),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          Platform.isIOS,
                      widgetBuilder: (BuildContext context) => MaterialButton(
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
                            Text('Continue with Apple',
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.black)),
                          ],
                        ),
                        onPressed: () async {
                          setState(() {
                            loggingIn = true;
                          });
                          signInWithApple().then((User user) {
                            if (user != null) {
                              updateUserData(_db, user);
                              createDefaultPreferences(_db, user);
                              setFCMData(_db, _fcm, user);
                              navigatorKey.currentState.pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                            }
                          });
                          setState(() {
                            loggingIn = false;
                          });
                        },
                      ),
                      fallbackBuilder: (BuildContext context) => SizedBox(height: 0),
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) => Platform.isIOS,
                      widgetBuilder: (BuildContext context) => SizedBox(height: 25),
                      fallbackBuilder: (BuildContext context) => SizedBox(height: 0)
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      minWidth: 100.0,
                      height: 45,
                      child:
                          Text('Continue without Account',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          loggingIn = true;
                        });
                        signInAnon().then((User user) {
                          if (user != null) {
                            updateUserData(_db, user);
                            createDefaultPreferences(_db, user);
                            setFCMData(_db, _fcm, user);
                            navigatorKey.currentState.pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          }
                        });
                        setState(() {
                          loggingIn = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
