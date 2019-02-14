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
      const Duration(seconds: 4),
    () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage('images/coconuts.jpg'), fit: BoxFit.fill),
                ),
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: new Image.asset(
                            'images/cardilogo.png'
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(top: 15.0),
                      ),
                      Text(
                         "CARDI Coconut Support Centre", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(padding: EdgeInsets.only(top: 20.0),
                        ),
                      Text("Online Information \n An effective partnership between CARDI & ITC",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
              )
          ],
          ),
        ],
      ),
    );
  }
}