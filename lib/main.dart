import 'package:flutter/material.dart';
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
              MaterialButton(
                onPressed: () => authService.googleSignIn(),
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Login with Google'),
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



