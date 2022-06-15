import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/widgets/delete_account.dart';
import 'package:water_track/widgets/unit_switch.dart';

import '../utils/constants.dart';
import 'goals.dart';
import 'notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var db = DatabaseService();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          width: sm.toDouble(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UnitSwitch(),
                const SizedBox(height: 16),
                const Goals(),
                const SizedBox(height: 16),
                const Notifications(),
                const SizedBox(height: 16),
                const DeleteAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
