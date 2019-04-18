import 'package:flutter/material.dart';
import "package:flutter_auth_buttons/flutter_auth_buttons.dart";
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutterbase'),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GoogleSignInButton(
                onPressed: () => authService.googleSignIn()
              ),
              MaterialButton(
                onPressed: () => authService.signOut(),
                color: Colors.red,
                textColor: Colors.black,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    authService.profile
      .listen((state) => setState(() => _profile = state));

    authService.loading
      .listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Text(_profile.toString()),
        ),
        Text(_loading.toString())
      ],
    );
  }
}
