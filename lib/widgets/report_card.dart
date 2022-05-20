import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({Key? key, required this.drink}) : super(key: key);
  final Drinks drink;

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat.MMMMd(Localizations.localeOf(context).languageCode).format(drink.date)}',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 16,
              child: FAProgressBar(
                direction: Axis.horizontal,
                maxValue: preferences.waterGoal.toDouble(),
                currentValue: drink.water.toDouble(),
                displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfWaterOz : AppLocalizations.of(context)!.reportOfWaterMl,
                backgroundColor: Colors.grey[200] ?? Colors.white,
                progressColor: Colors.blue[800] ?? Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              height: 16,
              child: FAProgressBar(
                direction: Axis.horizontal,
                maxValue: preferences.totalGoal.toDouble(),
                currentValue: drink.water +
                    drink.energyDrink +
                    drink.tea +
                    drink.coffee +
                    drink.sparklingWater +
                    drink.soda +
                    drink.sportsDrink +
                    drink.alcohol.toDouble(),
                displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfDrinkOz : AppLocalizations.of(context)!.reportOfDrinkMl,
                backgroundColor: Colors.grey[200] ?? Colors.white,
                progressColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
