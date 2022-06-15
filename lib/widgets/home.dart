import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';

import '../models/drink.dart';
import '../models/preferences.dart';
import '../utils/constants.dart';
import 'app_bar_ad.dart';
import 'buttons/buttons.dart';
import 'graph.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);
    var preferences = Provider.of<Preferences>(context);

    return MultiProvider(
      providers: [
        StreamProvider<Drinks>.value(
            initialData: Drinks.empty(),
            value: db.streamDrinks(user!.uid),
            catchError: (_, err) => Drinks.empty()),
      ],
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              preferences.adFree || MediaQuery.of(context).size.width < md
                  ? const SizedBox(height: 0)
                  : const AppBarAd(),
              const Graph(),
              const SizedBox(height: 16),
              Buttons()
            ],
          ),
        ),
      ),
    );
  }
}
