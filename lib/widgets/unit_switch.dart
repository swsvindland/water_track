import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/preferences.dart';
import 'package:water_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:water_track/utils/constants.dart';

class UnitSwitch extends StatefulWidget {
  const UnitSwitch({Key? key}) : super(key: key);

  @override
  State<UnitSwitch> createState() => _UnitSwitchState();
}

class _UnitSwitchState extends State<UnitSwitch> {
  final db = DatabaseService();
  final isSelected = [true, false];

  void onPressed(User? user, Preferences preferences) {
    if (preferences.unit == 'imperial' && isSelected[0]) return;
    if (preferences.unit == 'metric' && isSelected[1]) return;

    preferences.changeUnit();
    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          isSelected[0] = false;
          isSelected[1] = false;
          isSelected[index] = !isSelected[index];
        });
        onPressed(user, preferences);
      },
      isSelected: isSelected,
      selectedBorderColor: primaryVeryLight,
      children: [
        Text(
          AppLocalizations.of(context)!.imperial,
          style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),
        ),
        Text(
          AppLocalizations.of(context)!.metric,
          style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),
        )
      ],
    );
  }
}
