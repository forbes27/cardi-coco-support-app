import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RootScaffold(body: new Image.asset(
        'images/home.jpg'
      /*
      child: new SingleChildScrollView(
          child: new Column(
              children: <Widget>[
                 new Image.asset('images/home.jpg', fit: BoxFit.cover ,)
                /*
                new Text(
                  Welcome to the CARDI Coconut Support Centre,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40),
                ),
                */
              ]),

      ),
      */
    ));
  }
}

class RootDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Drawer(
        child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('CARDI Coconut Support Centre',textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
              ),

              ListTile(
                leading: Icon(Icons.home),
                  title: Text('Home', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUs()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('Pests', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pests()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Diseases', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Diseases()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Chat', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  }),
            ])
    );
  }
}

class RootScaffold extends StatelessWidget{

  final Widget body;

  RootScaffold({this.body});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text ('CARDI'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      drawer: new RootDrawer(),
      body: body,
    );
  }
}


