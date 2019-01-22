import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.greenAccent,
        child: new Center(
          child: new Text(
            "Welcome to the CARDI Coconut Support Center!",
            textDirection: TextDirection.ltr,
            style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 47),
          ),
        ));
  }


}