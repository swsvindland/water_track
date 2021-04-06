import 'package:flutter/material.dart';
import 'package:water_track/utils/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState!.pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Designed and Built by',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Sam Svindland',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Icons made by',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Good Ware from flaticon.com',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
