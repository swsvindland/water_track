import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:water_track/models/models.dart';
import 'package:water_track/services/graph_animation_provider.dart';
import 'package:water_track/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  static List<charts.Series<GraphDrinks, String>> _createData(Drinks drinks) {
    var none = drinks.water +
                drinks.energyDrink +
                drinks.tea +
                drinks.coffee +
                drinks.sparklingWater +
                drinks.soda +
                drinks.sportsDrink +
                drinks.alcohol ==
            0
        ? 1
        : 0;

    var data = [
      GraphDrinks('Water', drinks.water, primary),
      GraphDrinks('Sparkling Water', drinks.sparklingWater, primaryDark),
      GraphDrinks('Sports Drink', drinks.sportsDrink, primaryLight),
      GraphDrinks('Coffee', drinks.coffee, secondaryDark),
      GraphDrinks('Tea', drinks.tea, secondary),
      GraphDrinks('Soda', drinks.soda, ternary),
      GraphDrinks('Energy Drink', drinks.energyDrink, ternaryLight),
      GraphDrinks('Alcohol', drinks.alcohol, ternaryDark),
      GraphDrinks('None', none, Colors.grey[200]!)
    ];

    return [
      charts.Series<GraphDrinks, String>(
        id: 'Drinks',
        domainFn: (GraphDrinks drinks, _) => drinks.drink,
        measureFn: (GraphDrinks drinks, _) => drinks.value,
        colorFn: (GraphDrinks fluid, _) =>
            charts.ColorUtil.fromDartColor(fluid.colorval),
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<Drinks>(context);
    final preferences = Provider.of<Preferences>(context);
    var graphData = _createData(drinks);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          graphData.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: 200,
                  child: charts.PieChart<String>(graphData,
                      animate: context.watch<GraphAnimationProvider>().animate,
                      animationDuration: const Duration(milliseconds: 300),
                      defaultRenderer: charts.ArcRendererConfig(arcWidth: 180)))
              : Container(),
          const SizedBox(height: 8),
          SizedBox(
            width: 300,
            height: 16,
            child: FAProgressBar(
              maxValue: preferences.waterGoal.toDouble(),
              currentValue: drinks.water.toDouble(),
              displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfWaterOz : AppLocalizations.of(context)!.reportOfWaterMl,
              displayTextStyle: const TextStyle(color: background),
              backgroundColor: primary,
              progressColor: primaryLight,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 300,
            height: 16,
            child: FAProgressBar(
              maxValue: preferences.totalGoal.toDouble(),
              currentValue: drinks.water +
                  drinks.energyDrink +
                  drinks.tea +
                  drinks.coffee +
                  drinks.sparklingWater +
                  drinks.soda +
                  drinks.sportsDrink +
                  drinks.alcohol.toDouble(),
              displayText: preferences.unit == 'imperial' ? AppLocalizations.of(context)!.reportOfDrinkOz : AppLocalizations.of(context)!.reportOfDrinkMl,
              displayTextStyle: const TextStyle(color: background),
              backgroundColor: primary,
              progressColor: primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class GraphDrinks {
  String drink;
  int value;
  Color colorval;

  GraphDrinks(this.drink, this.value, this.colorval);
}
