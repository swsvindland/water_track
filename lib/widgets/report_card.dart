import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/models.dart';

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
              '${DateFormat.MMMMd().format(drink.date)}',
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
                maxValue: preferences.waterGoal,
                currentValue: drink.water,
                displayText: preferences.unit == 'imperial' ? 'oz of water' : 'ml of water',
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
                maxValue: preferences.totalGoal,
                currentValue: drink.water +
                    drink.energyDrink +
                    drink.tea +
                    drink.coffee +
                    drink.sparklingWater +
                    drink.soda +
                    drink.sportsDrink +
                    drink.alcohol,
                displayText: preferences.unit == 'imperial' ? 'oz of drinks' : 'ml of drinks',
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
