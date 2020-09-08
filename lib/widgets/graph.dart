import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/drink.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graph extends StatelessWidget {
  static final int total = 128;
  static final int totalWater = 96;

  static List<charts.Series<GraphDrinks, String>> _createData(Drinks drinks) {
    var none = drinks.water +
        drinks.energyDrink +
        drinks.tea +
        drinks.coffee +
        drinks.sparklingWater +
        drinks.soda >= total ? 0 : total - (drinks.water +
        drinks.energyDrink +
        drinks.tea +
        drinks.coffee +
        drinks.sparklingWater +
        drinks.soda);

    var data = [
      new GraphDrinks('Water', drinks.water, Colors.blue[800]),
      new GraphDrinks('Coffee', drinks.coffee, Colors.brown),
      new GraphDrinks('Sparkling Water', drinks.sparklingWater, Colors.orange),
      new GraphDrinks('Tea', drinks.tea, Colors.green),
      new GraphDrinks('Soda', drinks.soda, Colors.red),
      new GraphDrinks('Energy Drink', drinks.energyDrink, Colors.purple),
      new GraphDrinks('None', none, Colors.grey[200])
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: charts.PieChart(_createData(drinks),
                animate: true,
                animationDuration: Duration(milliseconds: 300),
                defaultRenderer: new charts.ArcRendererConfig(arcWidth: 30))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 150,
              child: FAProgressBar(
                verticalDirection: VerticalDirection.up,
                direction: Axis.vertical,
                maxValue: totalWater,
                currentValue: drinks.water,
                displayText: 'oz',
                backgroundColor: Colors.grey[200],
                progressColor: Colors.blue[800],
              ),
            ),
            SizedBox(width: 25),
            Container(
              width: 75,
              height: 150,
              child: FAProgressBar(
                verticalDirection: VerticalDirection.up,
                direction: Axis.vertical,
                maxValue: total,
                currentValue: drinks.water +
                    drinks.energyDrink +
                    drinks.tea +
                    drinks.coffee +
                    drinks.sparklingWater +
                    drinks.soda,
                displayText: 'oz',
                backgroundColor: Colors.grey[200],
                progressColor: Colors.blueGrey,
              ),
            ),
          ],
        )
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