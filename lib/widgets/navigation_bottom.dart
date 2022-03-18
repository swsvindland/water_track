import 'package:flutter/material.dart';
import 'package:water_track/utils/constants.dart';

class NavigationBottom extends StatelessWidget {
  const NavigationBottom({Key? key, required this.selectedIndex, required this.onItemTapped}) : super(key: key);
  final selectedIndex;
  final onItemTapped;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > sm) {
      return SizedBox();
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insights),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      onTap: onItemTapped,
    );
  }
}
