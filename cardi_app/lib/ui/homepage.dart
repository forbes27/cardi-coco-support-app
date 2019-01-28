import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text ('CARDI'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
          drawer: new Drawer(
            child: new ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Home'),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                ),
                ListTile(
                    title: Text('About'),
                    onTap: (){}),
                ListTile(
                  title: Text('Pests'),
                  onTap: (){}),
                ListTile(
                    title: Text('Diseases'),
                    onTap: (){}),
                ListTile(
                    title: Text('Chat'),
                    onTap: (){}),
                ListTile(
                    title: Text('Contact Us'),
                    onTap: (){}),
              ])


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