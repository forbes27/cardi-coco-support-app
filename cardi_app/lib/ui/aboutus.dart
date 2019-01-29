import 'package:flutter/material.dart';
import './homepage.dart';

class AboutUs extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootScaffold(body: new Center(
      child: new SingleChildScrollView(
          child: new Column(
              children: <Widget>[
                new Text(
                  "About Us!",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40),
                ),
                new Image.asset('images/cardi-01.png', height: 205.0, width: 175.0,)
              ])
      ),
    ));
  }
}
