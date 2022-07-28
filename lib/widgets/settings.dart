import 'package:flutter/material.dart';
import 'package:water_track/widgets/delete_account.dart';
import 'package:water_track/widgets/unit_switch.dart';

import '../utils/constants.dart';
import 'goals.dart';
import 'notifications.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: const <Widget>[
                UnitSwitch(),
                SizedBox(height: 16),
                Goals(),
                SizedBox(height: 16),
                Notifications(),
                SizedBox(height: 16),
                DeleteAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
