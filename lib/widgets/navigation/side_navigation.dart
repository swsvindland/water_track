import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_track/utils/constants.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      extended: true,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.local_drink, color: primaryDark, size: 36),
            const SizedBox(width: 16),
            Text(AppLocalizations.of(context)!.waterTrack,
                style: const TextStyle(fontSize: 24, color: primaryDark)),
          ],
        ),
      ),
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.home),
          label: Text(AppLocalizations.of(context)!.home),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.insights),
          label: Text(AppLocalizations.of(context)!.reports),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.settings),
          label: Text(AppLocalizations.of(context)!.settings),
        ),
        NavigationRailDestination(
          padding: const EdgeInsets.all(8),
          icon: const Icon(Icons.info),
          label: Text(AppLocalizations.of(context)!.about),
        ),
        NavigationRailDestination(
            padding: const EdgeInsets.all(8),
            icon: const Icon(Icons.logout),
            label: Text(AppLocalizations.of(context)!.logOut)),
      ],
    );
  }
}