import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:water_track/components/register.dart';
import 'package:water_track/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email, password, uid;
  String error = '';
  bool loggedIn = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<_SecItem> _items = [];
  final _storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _readAll();
    if (_items.length > 0) {
      onSubmit();
    }
    //print(_items);
  }

  Future<Null> _readAll() async {
    final all = await _storage.readAll();
    setState(() {
      return _items = all.keys
          .map((key) => new _SecItem(key, all[key]))
          .toList(growable: false);
    });
  }

  void onSubmit() async {
    try {
      final FirebaseUser user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);

      setState(() {
        loggedIn = true;
        uid = user.uid;
      });

      homePageState.setState(() {
        email = email;
        uid = uid;
      });

      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'password', value: password);
      await _storage.write(key: 'uid', value: uid);

      homePageState.setState(() {
        homePageState.body = MyHomePage();
      });
    } catch (err) {
      error = 'Incorrect email or password';
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
              SizedBox(
                height: 75.0,
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 45.0),
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
                    password = text;
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
                    "Login",
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
                      homePageState.body = RegisterPage();
                    });
                  },
                  child: Text(
                    "Sign Up",
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

class _SecItem {
  final String key;
  final String value;

  _SecItem(this.key, this.value);
}
