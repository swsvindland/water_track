import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:water_track/main.dart';

import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var name, email, passwordOne, passwordTwo, uid;
  String error = '';
  bool loggedIn = false;
  static DateTime now = new DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void onSubmit() async {
    try {
      if (passwordOne == passwordTwo) {
        final FirebaseUser user = await auth.createUserWithEmailAndPassword(
            email: email, password: passwordOne);

        assert(user != null);
        assert(await user.getIdToken() != null);

        loginUser();
      } else {
        error = 'Passwords are not the same';
      }
    } catch (err) {
      error = 'Something went wrong';
    }
  }

  void loginUser() async {
    try {
      final FirebaseUser user = await auth.signInWithEmailAndPassword(
          email: email, password: passwordOne);

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);

      setState(() {
        loggedIn = true;
        uid = user.uid;
      });

      Firestore.instance.collection('users').document(uid).setData({
        'name': name,
        'email': email,
        'uid': uid,
        'lastSeen': formattedDate
      });

      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'password', value: passwordOne);
      await _storage.write(key: 'uid', value: uid);

      homePageState.setState(() {
        homePageState.body = MyHomePage();
      });
    } catch (err) {
      setState(() {
        error = 'Incorrect email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Name",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                ),
                onChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
              ),
              SizedBox(height: 25.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                ),
                onChanged: (text) {
                  setState(() {
                    email = text;
                  });
                },
              ),
              SizedBox(height: 25.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    passwordOne = text;
                  });
                },
              ),
              SizedBox(height: 25.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Repeat Password",
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    passwordTwo = text;
                  });
                },
              ),
              SizedBox(height: 10.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                color: Colors.lightBlue[800],
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    onSubmit();
                  },
                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Material(
                elevation: 5.0,
                color: Colors.cyan[600],
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    homePageState.setState(() {
                      homePageState.body = LoginPage();
                    });
                  },
                  child: Text(
                    "Have an Account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
