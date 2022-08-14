import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.reminderNotification, style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 16, letterSpacing: 1),),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.start,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 24, letterSpacing: 1),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 12, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? const Text('error'),
                            );
                          },
                        );

                        setState(() {
                          start = picked!.hour;
                          set = true;
                        });
                      },
                      child: Text('$start:00', style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.end,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 24, letterSpacing: 1),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 12, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? const Text('error'),
                            );
                          },
                        );

                        setState(() {
                          end = picked!.hour;
                          set = true;
                        });
                      },
                      child: Text('$end:00', style: GoogleFonts.quicksand(color: primaryVeryLight, fontSize: 12, letterSpacing: 1),),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                update(user, preferences);
              },
              child: Text(
                AppLocalizations.of(context)!.update.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w100,
                  color: textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
