import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(),
      floatingActionButton: new FloatingActionButton(onPressed: null),
    );
  }
}