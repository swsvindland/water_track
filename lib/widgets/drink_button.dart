import 'package:flutter/material.dart';

class DrinkButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function inc;
  final Function dec;

  DrinkButton({Key key, @required this.title, @required this.color, @required this.inc, @required this.dec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          minWidth: 125.0,
          height: 35,
          color: color,
          child: new Text(title,
              style: new TextStyle(fontSize: 12.0, color: Colors.white)),
          onPressed: inc,
        ),
        MaterialButton(
          height: 35,
          minWidth: 35,
          onPressed: dec,
          elevation: 2.0,
          color: color,
          child: Icon(
            Icons.remove,
            size: 15.0,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        )
      ],
    ),
    );
  }
}
