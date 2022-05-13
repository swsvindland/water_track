import 'package:flutter/material.dart';
import 'package:water_track/utils/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: TextStyle(color: Colors.white)),
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
          padding: EdgeInsets.all(24),
          child: SizedBox(
            width: sm.toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Designed and Built by',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Sam Svindland',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: 36),
                Text(
                  'Version',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '2.0.1',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
