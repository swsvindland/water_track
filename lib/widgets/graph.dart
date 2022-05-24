import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:water_track/models/models.dart';
import 'package:water_track/services/graph_animation_provider.dart';
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
      GraphDrinks('Water', drinks.water, Colors.blue[800]!),
      GraphDrinks('Coffee', drinks.coffee, Colors.brown),
      GraphDrinks('Sparkling Water', drinks.sparklingWater, Colors.orange),
      GraphDrinks('Tea', drinks.tea, Colors.green),
      GraphDrinks('Soda', drinks.soda, Colors.red),
      GraphDrinks('Energy Drink', drinks.energyDrink, Colors.purple),
      GraphDrinks('Sports Drink', drinks.sportsDrink, Colors.yellow),
      GraphDrinks('Alcohol', drinks.alcohol, Colors.black54),
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        graphData.isNotEmpty
            ? Flexible(
                child: charts.PieChart<String>(graphData,
                    animate: context.watch<GraphAnimationProvider>().animate,
                    animationDuration: const Duration(milliseconds: 300),
                    defaultRenderer: charts.ArcRendererConfig(arcWidth: 30)))
            : Container(),
        SizedBox(
            height: 16,
            child: Text(AppLocalizations.of(context)!.breakdown,
                textAlign: TextAlign.center)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: MediaQuery.of(context).size.height * 0.15,
              child: FAProgressBar(
                verticalDirection: VerticalDirection.up,
                direction: Axis.vertical,
                maxValue: preferences.waterGoal.toDouble(),
                currentValue: drinks.water.toDouble(),
                displayText: preferences.unit == 'imperial' ? 'oz' : 'ml',
                backgroundColor: Colors.grey[200] ?? Colors.white,
                progressColor: Colors.blue[800] ?? Colors.blue,
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 60,
              height: MediaQuery.of(context).size.height * 0.15,
              child: FAProgressBar(
                verticalDirection: VerticalDirection.up,
                direction: Axis.vertical,
                maxValue: preferences.totalGoal.toDouble(),
                currentValue: drinks.water +
                    drinks.energyDrink +
                    drinks.tea +
                    drinks.coffee +
                    drinks.sparklingWater +
                    drinks.soda +
                    drinks.sportsDrink +
                    drinks.alcohol.toDouble(),
                displayText: preferences.unit == 'imperial' ? 'oz' : 'ml',
                backgroundColor: Colors.grey[200] ?? Colors.white,
                progressColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 60,
                height: 15,
                child: Text(AppLocalizations.of(context)!.water,
                    textAlign: TextAlign.center)),
            const SizedBox(width: 24),
            SizedBox(
                width: 60,
                height: 15,
                child: Text(AppLocalizations.of(context)!.total,
                    textAlign: TextAlign.center)),
          ],
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}

class GraphDrinks {
  String drink;
  int value;
  Color colorval;

  GraphDrinks(this.drink, this.value, this.colorval);
}
