import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/services/database_service.dart';

import '../models/drink.dart';
import '../models/preferences.dart';
import '../utils/constants.dart';
import 'buttons/buttons.dart';
import 'graph.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = DatabaseService();
    var user = Provider.of<User?>(context);
    var deviceSize = MediaQuery.of(context).size;

    var paddingFactor = deviceSize.width < xs
        ? 0.0
        : deviceSize.width < sm
        ? 4.0
        : 16.0;

    return StreamProvider<Drinks>.value(
      initialData: Drinks.empty(),
      value: db.streamDrinks(user!.uid),
      catchError: (_, err) => Drinks.empty(),
      child: StreamProvider<Preferences>.value(
        initialData: Preferences.empty(),
        value: db.streamPreferences(user.uid),
        catchError: (_, err) => Preferences.empty(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(paddingFactor, 0, paddingFactor, 0),
          child: deviceSize.width < sm
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Graph(),
                ),
              ),
              SizedBox(height: 16),
              Expanded(flex: 3, child: Buttons()),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 500,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Graph(),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(flex: 1, child: Buttons()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
