import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_track/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  final Widget child;

  SettingsPage({Key key, this.child}) : super(key: key);

  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Unit selectedUnit = Unit.imperial;

  void changeUnit() {
    if(selectedUnit == Unit.imperial) {
      setState(() {
        selectedUnit = Unit.metric;
      });
    } else {
      setState(() {
        selectedUnit = Unit.imperial;
      });
    }

    print(selectedUnit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            navigatorKey.currentState.pop();
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    disabledColor: Colors.grey[200],
                    minWidth: 100.0,
                    height: 35,
                    color: Colors.white,
                    child: new Text('Imperial'),
                    onPressed: selectedUnit == Unit.metric ? () => changeUnit() : null
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    disabledColor: Colors.grey[200],
                    minWidth: 100.0,
                    height: 35,
                    color: Colors.white,
                    child: new Text('Metric'),
                    onPressed: selectedUnit == Unit.imperial ? () => changeUnit() : null
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText:"Daily Water intake goal",
                          hintText: "Daily Water intake goal",
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Unit {imperial, metric}