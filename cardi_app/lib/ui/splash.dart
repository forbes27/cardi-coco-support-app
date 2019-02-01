import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SplashPageState();
  }

}

class _SplashPageState extends State<SplashPage>{
  @override

  void initState(){
    super.initState();
    new Future.delayed(
      const Duration(seconds: 3),
    () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text ('CARDI'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: new Center(
          child: new SingleChildScrollView(
              child: new Column(
                  children: <Widget>[
                    new Text(
                      "Splash!",
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