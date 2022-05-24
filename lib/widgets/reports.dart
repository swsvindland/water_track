import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/widgets/reports_list.dart';

import '../models/drink.dart';
import '../utils/constants.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: sm.toDouble(),
          child: StreamProvider<Iterable<Drinks>>.value(
            initialData: [Drinks.empty()],
            value: db.streamAllDrinks(user!.uid),
            child: const ReportsList()
          ),
        ),
      ),
    );
  }
}
