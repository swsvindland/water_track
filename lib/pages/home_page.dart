import 'package:flutter/material.dart';
import 'package:water_track/containers/counter/counter.dart';
import 'package:water_track/containers/counter/increase_counter.dart';
import 'package:water_track/containers/auth_button/auth_button_container.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new GoogleAuthButtonContainer(),
              new Text('You have pushed the button this many times: ',),
              new Counter(),
            ],
          )
        ),
      ),
      floatingActionButton: new IncreaseCountButton()
    );
  }
}