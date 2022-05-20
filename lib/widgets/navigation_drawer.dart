import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key, required this.selectedIndex, required this.onItemTapped}) : super(key: key);
  final selectedIndex;
  final onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.local_drink, color: Colors.white, size: 36),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.waterTrack,
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
            ),
          ),
          ListTile(
            selected: selectedIndex == 0,
            title: Text(AppLocalizations.of(context)!.home),
            leading: Icon(Icons.home),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: selectedIndex == 1,
            title: Text(AppLocalizations.of(context)!.reports),
            leading: Icon(Icons.insights),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: selectedIndex == 2,
            title: Text(AppLocalizations.of(context)!.settings),
            leading: Icon(Icons.settings),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              onItemTapped(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
