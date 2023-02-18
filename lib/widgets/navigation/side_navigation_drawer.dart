import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/sign_in.dart';
import '../../utils/constants.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({Key? key, required this.selectedIndex, required this.onItemTapped}) : super(key: key);
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListTileTheme(
        data: const ListTileThemeData(
          textColor: textPrimary
        ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: background,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.asset('images/logo.png', width: 36, height: 36),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.waterTrack,
                      style: const TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
            ),
          ),
          ListTile(
            selected: selectedIndex == 0,
            title: Text(AppLocalizations.of(context)!.home, style: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1)),
            leading: const Icon(Icons.home),
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
            title: Text(AppLocalizations.of(context)!.reports, style: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1)),
            leading: const Icon(Icons.insights),
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
            title: Text(AppLocalizations.of(context)!.settings, style: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1)),
            leading: const Icon(Icons.settings),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              onItemTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: selectedIndex == 3,
            title: Text(AppLocalizations.of(context)!.about, style: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1)),
            leading: const Icon(Icons.info),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              onItemTapped(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: selectedIndex == 4,
            title: Text(AppLocalizations.of(context)!.logOut, style: GoogleFonts.quicksand(fontSize: 12, letterSpacing: 1)),
            leading: const Icon(Icons.logout),
            onTap: () {
              signOut();
              navigatorKey.currentState!
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
      ),
    );
  }
}
