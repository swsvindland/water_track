import 'package:flutter/material.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/navigation_bottom.dart';
import 'package:water_track/widgets/navigation_drawer.dart';

import '../widgets/home.dart';
import '../widgets/reports.dart';
import '../widgets/settings.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('WaterTrack', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<Popup>(
              onSelected: (Popup result) {
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
        drawer: MediaQuery.of(context).size.width > sm ?  NavigationDrawer(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped) : null,
        body: _selectedIndex == 0 ? Home() : _selectedIndex == 1 ? Reports() : Settings(),
      bottomNavigationBar: MediaQuery.of(context).size.width < sm ?  NavigationBottom(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped) : null,
    );
  }
}

enum Popup { about, logOut }
