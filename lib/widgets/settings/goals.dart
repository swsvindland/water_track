import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_track/utils/constants.dart';

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
    var brightness = MediaQuery.of(context).platformBrightness;
    var isDarkMode = brightness == Brightness.dark;

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
                Text('${AppLocalizations.of(context)!.water}: ${preferences.waterGoal.toString()}', style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),),
                Text('${AppLocalizations.of(context)!.total}: ${preferences.totalGoal.toString()}', style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),),
                Text('${AppLocalizations.of(context)!.drinkSize}: ${preferences.drinkSize.toString()}', style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.waterGoalField,
                labelStyle: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),
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
                labelStyle: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),
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
                labelStyle: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),
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
                AppLocalizations.of(context)!.update.toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w100,
                  color: isDarkMode ? primaryVeryLight : textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
