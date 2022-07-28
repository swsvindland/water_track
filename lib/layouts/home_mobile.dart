import 'package:flutter/material.dart';
import 'package:water_track/services/sign_in.dart';
import 'package:water_track/utils/constants.dart';
import 'package:water_track/widgets/app_bar_ad.dart';
import 'package:water_track/widgets/navigation/navigation_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/home.dart';
import '../widgets/reports.dart';
import '../widgets/settings.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
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
          title: const AppBarAd(),
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
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Popup>>[
                PopupMenuItem<Popup>(
                  value: Popup.about,
                  child: ListTile(
                    leading: const Icon(Icons.info),
                    title: Text(AppLocalizations.of(context)!.about, style: const TextStyle(color: textPrimary)),
                  ),
                ),
                PopupMenuItem<Popup>(
                  value: Popup.logOut,
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(AppLocalizations.of(context)!.logOut, style: const TextStyle(color: textPrimary)),
                  ),
                ),
              ].toList(),
            ),
          ],
        ),
        body: _selectedIndex == 0
            ? const Home()
            : _selectedIndex == 1
                ? const Reports()
                : const Settings(),
        bottomNavigationBar: NavigationBottom(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped));
  }
}

enum Popup { about, logOut }
