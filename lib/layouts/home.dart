import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_track/models/drink.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/buttons/buttons.dart';
import 'package:water_track/layouts/about.dart';
import 'package:provider/provider.dart';
import 'package:water_track/widgets/graph.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<Popup>(
              onSelected: (Popup result) {
                if (result == Popup.about) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                }
                if (result == Popup.logOut) {
                  signOut();
                  navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
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
          value: db.streamDrinks(user.uid),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Graph()
              ),
              SizedBox(height: 75),
              Expanded(
                flex: 3,
                child: Buttons()
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Popup { about, settings, logOut }
