import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/sign_in.dart';
import '../utils/constants.dart';
import '../widgets/about.dart';
import '../widgets/app_bar_ad.dart';
import '../widgets/home.dart';
import '../widgets/navigation/side_navigation_drawer.dart';
import '../widgets/reports.dart';
import '../widgets/settings/settings.dart';

class HomePageTablet extends StatefulWidget {
  const HomePageTablet({Key? key}) : super(key: key);

  @override
  State<HomePageTablet> createState() => _HomePageTabletState();
}

class _HomePageTabletState extends State<HomePageTablet> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 5) {
      signOut();
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/login', (route) => false);
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    if (user == null) {
      return const CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppBarAd(),
        elevation: 0,
      ),
      drawer: SideNavigationDrawer(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      body: _selectedIndex == 0
          ? const Home()
          : _selectedIndex == 1
              ? const Reports()
              : _selectedIndex == 2
                  ? const Settings()
                  : const About(),
    );
  }
}
