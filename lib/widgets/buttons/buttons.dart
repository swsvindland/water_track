import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/drink.dart';
import 'package:water_track/services/database_service.dart';
import '../drink_button.dart';

class Buttons extends StatelessWidget {
  final db = DatabaseService();

  void incDrink(User user, Drinks drinks, String drink) async {
    drinks.increment(drink);
    db.updateDrinks(user.uid, drinks);
  }

  void decDrink(User user, Drinks drinks, String drink) async {
    drinks.decrement(drink);
    db.updateDrinks(user.uid, drinks);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final drinks = Provider.of<Drinks>(context);

    return Wrap(
      children: <Widget>[
        DrinkButton(
            title: 'Water',
            color: Colors.blue[800],
            inc: () => incDrink(user, drinks, 'water'),
            dec: () => decDrink(user, drinks, 'water')),
        DrinkButton(
            title: 'Coffee',
            color: Colors.brown,
            inc: () => incDrink(user, drinks, 'coffee'),
            dec: () => decDrink(user, drinks, 'coffee')),
        DrinkButton(
            title: 'Sparkling Water',
            color: Colors.orange,
            inc: () => incDrink(user, drinks, 'sparklingWater'),
            dec: () => decDrink(user, drinks, 'sparklingWater')),
        DrinkButton(
            title: 'Tea',
            color: Colors.lightGreen,
            inc: () => incDrink(user, drinks, 'tea'),
            dec: () => decDrink(user, drinks, 'tea')),
        DrinkButton(
            title: 'Soda',
            color: Colors.red,
            inc: () => incDrink(user, drinks, 'soda'),
            dec: () => decDrink(user, drinks, 'soda')),
        DrinkButton(
            title: 'Energy Drink',
            color: Colors.purple,
            inc: () => incDrink(user, drinks, 'energyDrink'),
            dec: () => decDrink(user, drinks, 'energyDrink')),
      ],
    );
  }
}
