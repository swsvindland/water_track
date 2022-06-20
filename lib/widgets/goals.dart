import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_track/utils/constants.dart';

import 'buttons/button.dart';

class Goals extends StatefulWidget {
  const Goals({Key? key}) : super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final db = DatabaseService();
  late String waterGoal;
  late String totalGoal;
  late String drinkSize;

  void onPressed(User? user, Preferences preferences) {
    preferences.changeUnit();
    db.updatePreferences(user!.uid, preferences);
  }

  void updateGoals(User? user, Preferences preferences) {
    if (waterGoal != "") {
      preferences.setWaterGoal(int.parse(waterGoal));
    }

    if (totalGoal != "") {
      preferences.setTotalGoal(int.parse(totalGoal));
    }

    if (drinkSize != "") {
      preferences.setDrinkSize(int.parse(drinkSize));
    }

    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${AppLocalizations.of(context)!.water}: ${preferences.waterGoal.toString()}'),
                Text('${AppLocalizations.of(context)!.total}: ${preferences.totalGoal.toString()}'),
                Text('${AppLocalizations.of(context)!.drinkSize}: ${preferences.drinkSize.toString()}'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.waterGoalField,
                labelStyle: const TextStyle(color: primaryVeryLight)
              ),
              onChanged: (value) {
                waterGoal = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.fluidGoalField,
                  labelStyle: const TextStyle(color: primaryVeryLight)
              ),
              onChanged: (value) {
                totalGoal = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.drinkSizeField,
                  labelStyle: const TextStyle(color: primaryVeryLight)
              ),
              onChanged: (value) {
                drinkSize = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                updateGoals(user, preferences);
              },
              child: Text(
                AppLocalizations.of(context)!.update,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
