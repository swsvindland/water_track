import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';

class Notifications extends StatefulWidget {
  Notifications() : super();

  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final db = DatabaseService();
  late int start;
  late int end;
  bool set = false;

  void update(User? user, Preferences preferences) {
    preferences.setStartTime(start);
    preferences.setEndTime(end);
    set = false;

    db.updatePreferences(user!.uid, preferences);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final preferences = Provider.of<Preferences>(context);

    setState(() {
      if (!set) {
        start = preferences.start;
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
            Text('Reminder Notification'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Start",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 12, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? new Text('error'),
                            );
                          },
                        );

                        setState(() {
                          start = picked!.hour;
                          set = true;
                        });
                      },
                      child: Text('$start:00'),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      "End",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 12, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? new Text('error'),
                            );
                          },
                        );

                        setState(() {
                          end = picked!.hour;
                          set = true;
                        });
                      },
                      child: Text('$end:00'),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
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
