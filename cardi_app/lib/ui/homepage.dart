import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';
import 'package:cardi_app/models/pest.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //place more multiple widgets into a parent called Container
    Widget titleSection = new Container(

      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFFE8F5E9), const Color(0xFF43A047) ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.2,1.1],
            tileMode: TileMode.clamp
        ),
      ),
      padding: const EdgeInsets.all(15.0),//top, bottom, left, right
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child:  new Text("CARDI Coconut Support Centre",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.grey[800],
                            fontSize: 25.0)
                    ),
                  ),

                  new Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                        child:  new Text("This application is to help small-farmer producers and stakeholders to have access to any information concerning the different types of coconut pests and diseases risk mitigation control methods used in the Coconut Industry.",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                            color:Colors.grey[750],
                            fontSize: 20.0)
                            ),
                  ),

                  new ListTile(
                      title: Text ('Pests & Diseases of Coconuts'),
                      subtitle: Text('Visit this article at '),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PestsPage()),
                        );
                      }
                    ),

                  new ListTile(
                    title: Text ('Challenges in the Coconut Industry and Srategies to Overcome Them'),
                    subtitle: Text('Visit this article at '),
                  ),

                  new ListTile(
                    title: Text ('CARDI and Teleios Code Jam 2018'),
                    subtitle: Text('Visit this article at '),
                  ),
                ],
              ),
          ),
        ]
      ),
    );

    return new RootScaffold(
      title: "Home",
      body: new ListView(
        children: <Widget>[
          new Image.asset(
              'images/coconutFarm.jpg',
            fit: BoxFit.fill
          ),
          //We can add more widgets below
          titleSection,
        ]
      )
      );
  }//end build method

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
                  color: Colors.green,
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
                      MaterialPageRoute(builder: (context) => PestsPage()),
                    );
                  }),
              ListTile(

                  leading: Icon(Icons.bug_report),

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

//class RootScaffold extends StatelessWidget{
//
//  final Widget body;
//
//  RootScaffold({this.body});
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text ('CARDI'),
//        centerTitle: true,
//        backgroundColor: Colors.greenAccent,
//      ),
//      drawer: new RootDrawer(),
//      body: body,
//    );
//  }
//}

class RootScaffold extends StatelessWidget{

  final Widget body;
  final String title;

  RootScaffold({this.body,this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text (title),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: new RootDrawer(),
      body: body,
    );
  }
}