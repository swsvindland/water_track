import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:water_track/models/models.dart';
import 'package:water_track/services/graph_animation_provider.dart';

class Graph extends StatelessWidget {
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
      new GraphDrinks('Water', drinks.water, Colors.blue[800]!),
      new GraphDrinks('Coffee', drinks.coffee, Colors.brown),
      new GraphDrinks('Sparkling Water', drinks.sparklingWater, Colors.orange),
      new GraphDrinks('Tea', drinks.tea, Colors.green),
      new GraphDrinks('Soda', drinks.soda, Colors.red),
      new GraphDrinks('Energy Drink', drinks.energyDrink, Colors.purple),
      new GraphDrinks('Sports Drink', drinks.sportsDrink, Colors.yellow),
      new GraphDrinks('Alcohol', drinks.alcohol, Colors.black),
      new GraphDrinks('None', none, Colors.grey[200]!)
    ];

    return [
      new charts.Series<GraphDrinks, String>(
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
        graphData.length > 0
            ? Flexible(
                child: charts.PieChart<String>(graphData,
                    animate: context.watch<GraphAnimationProvider>().animate,
                    animationDuration: Duration(milliseconds: 300),
                    defaultRenderer:
                        new charts.ArcRendererConfig(arcWidth: 30)))
            : Container(),
        Container(
            height: 16, child: Text("Breakdown", textAlign: TextAlign.center)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
            SizedBox(width: 24),
            Container(
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
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 60,
                height: 15,
                child: Text("Water", textAlign: TextAlign.center)),
            SizedBox(width: 24),
            Container(
                width: 60,
                height: 15,
                child: Text("Total", textAlign: TextAlign.center)),
          ],
        ),
        SizedBox(height: 8)
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
