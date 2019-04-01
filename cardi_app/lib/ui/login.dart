import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}


class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}


class LoginPageState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('images/coconuts.jpg'), fit: BoxFit.fill),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(bottom: 300.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: new Image.asset(
                          'images/cardilogo.png',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "CARDI Coconut Support Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //Row for login button
          new Container(
            padding: new EdgeInsets.only(top: 650.0),
            margin: new EdgeInsets.all(50.0),
            child: new Row(
              children: <Widget>[
                new MaterialButton(
                  height: 40.0,
                  minWidth: 300.0,
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("Login/Register",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: ()=>{},
                  splashColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
