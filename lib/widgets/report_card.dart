import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({Key? key, required this.drink}) : super(key: key);
  final Drinks drink;

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.MMMMd(Localizations.localeOf(context).languageCode).format(drink.date),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, color: primaryVeryLight),
            ),
            const Divider(),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              height: 16,
              child: FAProgressBar(
                direction: Axis.horizontal,
                maxValue: preferences.waterGoal.toDouble(),
                currentValue: drink.water.toDouble(),
                displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfWaterOz : AppLocalizations.of(context)!.reportOfWaterMl,
                displayTextStyle: const TextStyle(color: background),
                backgroundColor: primary,
                progressColor: primaryLight,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              height: 16,
              child: FAProgressBar(
                direction: Axis.horizontal,
                maxValue: preferences.totalGoal.toDouble(),
                currentValue: drink.water +
                    drink.energyDrink +
                    drink.dietEnergyDrink +
                    drink.preWorkout +
                    drink.tea +
                    drink.milk +
                    drink.coffee +
                    drink.sparklingWater +
                    drink.soda +
                    drink.dietSoda +
                    drink.sportsDrink +
                    drink.dietSportsDrink.toDouble(),
                displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfDrinkOz : AppLocalizations.of(context)!.reportOfDrinkMl,
                displayTextStyle: const TextStyle(color: background),
                backgroundColor: primary,
                progressColor: primaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
