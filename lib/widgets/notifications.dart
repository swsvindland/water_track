import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/preferences.dart';
import 'package:water_track/services/database_service.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final db = DatabaseService();
  int start;
  int end;

  void update(User user, Preferences preferences) {
    preferences.setStartTime(start);
    preferences.setEndTime(end);

    db.updatePreferences(user.uid, preferences);
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final preferences = Provider.of<Preferences>(context);

    setState(() {
      if (start == null) {
        start = preferences.start;
      }
      if (end == null) {
        end = preferences.end;
      }
    });

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Start",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36),
                ),
                Text(
                  "End",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    TimeOfDay picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 12, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    );

                    setState(() {
                      start = picked.hour;
                    });
                  },
                  child: Text(
                    "${start}:00",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 12, minute: 00),
                      builder: (BuildContext context, Widget child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child,
                        );
                      },
                    );

                    setState(() {
                      end = picked.hour;
                    });
                  },
                  child: Text(
                    "${end}:00",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              ],
            ),
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
                update(user, preferences);
              },
            ),
          ],
        ),
      ),
    );
  }
}
