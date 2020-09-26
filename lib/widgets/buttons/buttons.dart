import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/drink.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import '../drink_button.dart';

class Buttons extends StatelessWidget {
  final db = DatabaseService();

  void incDrink(User user, Drinks drinks, String drink, GraphAnimationProvider graphAnimationProvider) async {
    graphAnimationProvider.setAnimate(false);
    drinks.increment(drink);
    db.updateDrinks(user.uid, drinks);
  }

  void decDrink(User user, Drinks drinks, String drink, GraphAnimationProvider graphAnimationProvider) async {
    graphAnimationProvider.setAnimate(false);
    drinks.decrement(drink);
    db.updateDrinks(user.uid, drinks);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final drinks = Provider.of<Drinks>(context);
    final graphAnimation = Provider.of<GraphAnimationProvider>(context);

    return Wrap(
      children: <Widget>[
        DrinkButton(
            title: 'Water',
            color: Colors.blue[800],
            inc: () => incDrink(user, drinks, 'water', graphAnimation),
            dec: () => decDrink(user, drinks, 'water', graphAnimation)),
        DrinkButton(
            title: 'Coffee',
            color: Colors.brown,
            inc: () => incDrink(user, drinks, 'coffee', graphAnimation),
            dec: () => decDrink(user, drinks, 'coffee', graphAnimation)),
        DrinkButton(
            title: 'Sparkling Water',
            color: Colors.orange,
            inc: () => incDrink(user, drinks, 'sparklingWater', graphAnimation),
            dec: () => decDrink(user, drinks, 'sparklingWater', graphAnimation)),
        DrinkButton(
            title: 'Tea',
            color: Colors.lightGreen,
            inc: () => incDrink(user, drinks, 'tea', graphAnimation),
            dec: () => decDrink(user, drinks, 'tea', graphAnimation)),
        DrinkButton(
            title: 'Sports Drink',
            color: Colors.yellow,
            textColor: Colors.black,
            inc: () => incDrink(user, drinks, 'sportsDrink', graphAnimation),
            dec: () => decDrink(user, drinks, 'sportsDrink', graphAnimation)),
        DrinkButton(
            title: 'Energy Drink',
            color: Colors.purple,
            inc: () => incDrink(user, drinks, 'energyDrink', graphAnimation),
            dec: () => decDrink(user, drinks, 'energyDrink', graphAnimation)),
        DrinkButton(
            title: 'Soda',
            color: Colors.red,
            inc: () => incDrink(user, drinks, 'soda', graphAnimation),
            dec: () => decDrink(user, drinks, 'soda', graphAnimation)),
        DrinkButton(
            title: 'Alcohol',
            color: Colors.black,
            inc: () => incDrink(user, drinks, 'alcohol', graphAnimation),
            dec: () => decDrink(user, drinks, 'alcohol', graphAnimation)),
        ]
    );
  }
}
