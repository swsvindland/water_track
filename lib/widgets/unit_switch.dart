import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/preferences.dart';
import 'package:water_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitSwitch extends StatelessWidget {
  UnitSwitch({Key? key}) : super(key: key);

  final db = DatabaseService();

  void onPressed(User? user, Preferences preferences) {
    preferences.changeUnit();
    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey[200],
            minWidth: 100.0,
            height: 35,
            color: Colors.white,
            onPressed: preferences.unit == 'metric'
                ? () => onPressed(user, preferences)
                : null,
            child: Text(AppLocalizations.of(context)!.imperial)),
        MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey[200],
            minWidth: 100.0,
            height: 35,
            color: Colors.white,
            onPressed: preferences.unit == 'imperial'
                ? () => onPressed(user, preferences)
                : null,
            child: Text(AppLocalizations.of(context)!.metric)),
      ],
    );
  }
}
