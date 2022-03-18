import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/drink.dart';
import 'package:water_track/widgets/report_card.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drinks = Provider.of<Iterable<Drinks>>(context).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: drinks.length,
      itemBuilder: (BuildContext context, int index) {
        return ReportCard(drink: drinks[index]);
      },
    );
  }
}
