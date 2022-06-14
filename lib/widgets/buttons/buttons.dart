import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:water_track/services/database_service.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import '../../utils/constants.dart';
import 'drink_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Buttons extends StatelessWidget {
  Buttons({Key? key}) : super(key: key);

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

    Widget waterDrinks = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DrinkButton(
            title: AppLocalizations.of(context)!.sparklingWater,
            color: primaryDark,
            inc: () => incDrink(user, drinks, 'sparklingWater', graphAnimation,
                preferences.drinkSize),
            dec: () => decDrink(user, drinks, 'sparklingWater', graphAnimation,
                preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.sportsDrink,
            color: primaryLight,
            textColor: Colors.black,
            inc: () => incDrink(user, drinks, 'sportsDrink', graphAnimation,
                preferences.drinkSize),
            dec: () => decDrink(user, drinks, 'sportsDrink', graphAnimation,
                preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.sportsDrink,
            color: primaryLight,
            textColor: Colors.black,
            inc: () => incDrink(user, drinks, 'dietSportsDrink', graphAnimation,
                preferences.drinkSize),
            dec: () => decDrink(user, drinks, 'dietSportsDrink', graphAnimation,
                preferences.drinkSize)),
      ],
    );

    Widget dirtDrinks = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DrinkButton(
            title: AppLocalizations.of(context)!.coffee,
            color: secondaryDark,
            inc: () => incDrink(
                user, drinks, 'coffee', graphAnimation, preferences.drinkSize),
            dec: () => decDrink(
                user, drinks, 'coffee', graphAnimation, preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.tea,
            color: secondary,
            inc: () => incDrink(
                user, drinks, 'tea', graphAnimation, preferences.drinkSize),
            dec: () => decDrink(
                user, drinks, 'tea', graphAnimation, preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.milk,
            color: secondaryLight,
            inc: () => incDrink(
                user, drinks, 'milk', graphAnimation, preferences.drinkSize),
            dec: () => decDrink(
                user, drinks, 'milk', graphAnimation, preferences.drinkSize)),
      ],
    );

    Widget chemDrinks = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DrinkButton(
            title: AppLocalizations.of(context)!.energyDrink,
            color: ternaryLight,
            textColor: Colors.black,
            inc: () => incDrink(user, drinks, 'energyDrink', graphAnimation,
                preferences.drinkSize),
            dec: () => decDrink(user, drinks, 'energyDrink', graphAnimation,
                preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.soda,
            color: ternary,
            textColor: Colors.black,
            inc: () => incDrink(
                user, drinks, 'soda', graphAnimation, preferences.drinkSize),
            dec: () => decDrink(
                user, drinks, 'soda', graphAnimation, preferences.drinkSize)),
        const SizedBox(height: 16),
        DrinkButton(
            title: AppLocalizations.of(context)!.soda,
            color: ternaryDark,
            textColor: Colors.black,
            inc: () => incDrink(
                user, drinks, 'dietSoda', graphAnimation, preferences.drinkSize),
            dec: () => decDrink(user, drinks, 'dietSoda', graphAnimation,
                preferences.drinkSize)),
      ],
    );

    return SizedBox(
      width: 600,
      child: Column(
        children: [
          DrinkButton(
              title: AppLocalizations.of(context)!.water,
              color: primary,
              inc: () => incDrink(
                  user, drinks, 'water', graphAnimation, preferences.drinkSize),
              dec: () => decDrink(user, drinks, 'water', graphAnimation,
                  preferences.drinkSize)),
          const SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(height: 250.0, viewportFraction: 1),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: primary, borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Center(
                        child: i == 1
                            ? waterDrinks
                            : i == 2
                                ? dirtDrinks
                                : chemDrinks),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
