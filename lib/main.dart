import 'package:flutter/material.dart';
import "package:flutter_auth_buttons/flutter_auth_buttons.dart";
import 'auth.dart';
import 'login.dart';
import 'pages/home_page.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  String title = 'Me Suite';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title,
      home: new HomePage(title),
    );
  }
}