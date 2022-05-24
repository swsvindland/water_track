import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.onPressed, required this.child, this.variant})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final String? variant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(const Size(300, 35)),
        foregroundColor: MaterialStateProperty.all<Color>(variant == 'secondary' ? Colors.white : Colors.black),
        backgroundColor: MaterialStateProperty.all<Color>(variant == 'secondary' ?  Theme.of(context).primaryColor : Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}