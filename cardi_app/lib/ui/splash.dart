import 'package:flutter/material.dart';
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text ('CARDI'),
          centerTitle: true,
        backgroundColor: Colors.greenAccent,
        ),
        body: new Center(
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Text(
                  "Welcome to the Coconut Support Center!",
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