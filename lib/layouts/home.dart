import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/buttons/buttons.dart';
import 'package:provider/provider.dart';
import 'package:water_track/widgets/graph.dart';

class HomePage extends StatelessWidget {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('WaterTrack', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<Popup>(
              onSelected: (Popup result) {
                if (result == Popup.settings) {
                  navigatorKey.currentState!.pushNamed('/settings');
                }
                if (result == Popup.about) {
                  navigatorKey.currentState!.pushNamed('/about');
                }
                if (result == Popup.logOut) {
                  signOut();
                  navigatorKey.currentState!
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
                const PopupMenuItem<Popup>(
                  value: Popup.settings,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<Popup>(
                  value: Popup.about,
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                  ),
                ),
                const PopupMenuItem<Popup>(
                  value: Popup.logOut,
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log Out'),
                  ),
                ),
              ].toList(),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: StreamProvider<Drinks>.value(
          initialData: Drinks.empty(),
          value: db.streamDrinks(user!.uid),
          child: StreamProvider<Preferences>.value(
            initialData: Preferences.empty(),
            value: db.streamPreferences(user.uid),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Graph(),
                  ),
                ),
                SizedBox(height: 25),
                Expanded(flex: 3, child: Buttons()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Popup { about, settings, logOut }
