import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/drink.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'drink_button.dart';

class Buttons extends StatelessWidget {
  final db = DatabaseService();

  void incDrink(User? user, Drinks drinks, String drink,
      GraphAnimationProvider graphAnimationProvider, int value) async {
    graphAnimationProvider.setAnimate(false);
    drinks.increment(drink, value);
    db.updateDrinks(user!.uid, drinks);
  }

  void decDrink(User? user, Drinks drinks, String drink,
      GraphAnimationProvider graphAnimationProvider, int value) async {
    graphAnimationProvider.setAnimate(false);
    drinks.decrement(drink, value);
    db.updateDrinks(user!.uid, drinks);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final drinks = Provider.of<Drinks>(context);
    final graphAnimation = Provider.of<GraphAnimationProvider>(context);
    final preferences = Provider.of<Preferences>(context);

    return Wrap(spacing: 10.0, children: <Widget>[
      DrinkButton(
          title: 'Water',
          color: Colors.blue[800],
          inc: () => incDrink(
              user, drinks, 'water', graphAnimation, preferences.drinkSize),
          dec: () => decDrink(
              user, drinks, 'water', graphAnimation, preferences.drinkSize)),
      DrinkButton(
          title: 'Coffee',
          color: Colors.brown,
          inc: () => incDrink(
              user, drinks, 'coffee', graphAnimation, preferences.drinkSize),
          dec: () => decDrink(
              user, drinks, 'coffee', graphAnimation, preferences.drinkSize)),
      DrinkButton(
          title: 'Sparkling Water',
          color: Colors.orange,
          inc: () => incDrink(user, drinks, 'sparklingWater', graphAnimation,
              preferences.drinkSize),
          dec: () => decDrink(user, drinks, 'sparklingWater', graphAnimation,
              preferences.drinkSize)),
      DrinkButton(
          title: 'Tea',
          color: Colors.lightGreen,
          inc: () => incDrink(
              user, drinks, 'tea', graphAnimation, preferences.drinkSize),
          dec: () => decDrink(
              user, drinks, 'tea', graphAnimation, preferences.drinkSize)),
      DrinkButton(
          title: 'Sports Drink',
          color: Colors.yellow,
          textColor: Colors.black,
          inc: () => incDrink(user, drinks, 'sportsDrink', graphAnimation,
              preferences.drinkSize),
          dec: () => decDrink(user, drinks, 'sportsDrink', graphAnimation,
              preferences.drinkSize)),
      DrinkButton(
          title: 'Energy Drink',
          color: Colors.purple,
          inc: () => incDrink(user, drinks, 'energyDrink', graphAnimation,
              preferences.drinkSize),
          dec: () => decDrink(user, drinks, 'energyDrink', graphAnimation,
              preferences.drinkSize)),
      DrinkButton(
          title: 'Soda',
          color: Colors.red,
          inc: () => incDrink(
              user, drinks, 'soda', graphAnimation, preferences.drinkSize),
          dec: () => decDrink(
              user, drinks, 'soda', graphAnimation, preferences.drinkSize)),
      DrinkButton(
          title: 'Alcohol',
          color: Colors.black,
          inc: () => incDrink(
              user, drinks, 'alcohol', graphAnimation, preferences.drinkSize),
          dec: () => decDrink(
              user, drinks, 'alcohol', graphAnimation, preferences.drinkSize)),
    ]);
  }
}
