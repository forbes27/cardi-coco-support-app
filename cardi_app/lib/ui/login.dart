import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Center(
            child: new Container(
              color: Colors.greenAccent,
              child:new Column( crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(child:
                  new Text("Enter username:", textDirection: TextDirection.ltr,
                    style: new TextStyle(fontSize: 17, color: Colors.white),),),
                  new Center(child:new Text("Textbox", textDirection: TextDirection.ltr,
                    style: new TextStyle(fontSize: 17, color: Colors.white),))
              ]),
              new Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Password:", textDirection: TextDirection.ltr,
                    style: new TextStyle(fontSize: 17, color: Colors.white),),
                  new Text("Textbox", textDirection: TextDirection.ltr,
                    style: new TextStyle(fontSize: 17, color: Colors.white),)
                ]),
              new Text("Login", textDirection: TextDirection.ltr,
                style: new TextStyle(fontSize: 17, color: Colors.white)),
              new Text("Register", textDirection: TextDirection.ltr,
                style: new TextStyle(fontSize: 17, color: Colors.white)),
      ]))));

  }


}