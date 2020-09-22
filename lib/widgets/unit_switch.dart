import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_track/models/preferences.dart';

class UnitSwitch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<Preferences>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey[200],
            minWidth: 100.0,
            height: 35,
            color: Colors.white,
            child: new Text('Imperial'),
            onPressed: preferences.unit == Unit.metric ? () => preferences.changeUnit() : null),
        MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey[200],
            minWidth: 100.0,
            height: 35,
            color: Colors.white,
            child: new Text('Metric'),
            onPressed:
                preferences.unit == Unit.imperial ? () => preferences.changeUnit() : null),
      ],
    );
  }
}
