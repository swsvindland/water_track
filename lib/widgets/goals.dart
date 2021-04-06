import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';

class Goals extends StatefulWidget {
  Goals() : super();

  _GoalsState createState() => _GoalsState();
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
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('water: ${preferences.waterGoal.toString()}'),
                Text('total: ${preferences.totalGoal.toString()}'),
                Text('drink size: ${preferences.drinkSize.toString()}'),
              ],
            ),
            SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter daily water goal',
              ),
              onChanged: (value) {
                waterGoal = value;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter daily fluid goal',
              ),
              onChanged: (value) {
                totalGoal = value;
              },
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your drink size',
              ),
              onChanged: (value) {
                drinkSize = value;
              },
            ),
            SizedBox(height: 25),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              minWidth: 125.0,
              height: 35,
              color: Colors.blue,
              child: new Text(
                'Update',
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                updateGoals(user, preferences);
              },
            ),
          ],
        ),
      ),
    );
  }
}
