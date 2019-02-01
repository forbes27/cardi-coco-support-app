import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new RootScaffold(body: new Center(
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
              ])
      ),
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
                  title: Text('Home', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }),
              ListTile(
                  title: Text('About Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUs()),
                    );
                  }),
              ListTile(
                  title: Text('Pests', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pests()),
                    );
                  }),
              ListTile(
                  title: Text('Diseases', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Diseases()),
                    );
                  }),
              ListTile(
                  title: Text('Chat', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chat()),
                    );
                  }),
              ListTile(
                  title: Text('Contact Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,),
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


