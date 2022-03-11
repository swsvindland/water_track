import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/goals.dart';
import 'package:water_track/widgets/notifications.dart';
import 'package:water_track/widgets/unit_switch.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage() : super();

  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
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
      body: StreamProvider<Preferences>.value(
        initialData: Preferences.empty(),
        value: db.streamPreferences(user!.uid),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UnitSwitch(),
                  SizedBox(height: 15),
                  Goals(),
                  Notifications()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
