import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_track/models/preferences.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/utils/helper.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreenPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    navigateUser();
  }

  navigateUser() {
    User currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null || currentUser.uid == null) {
      Timer(Duration(milliseconds: 850),
              () => navigatorKey.currentState.pushReplacementNamed("/login"));
    } else {
      Timer(
        Duration(milliseconds: 500),
            () {
          updateUserData(_db, currentUser);
          createDefaultPreferences(_db, currentUser);
          navigatorKey.currentState.pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
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
              SizedBox(height: 75),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
