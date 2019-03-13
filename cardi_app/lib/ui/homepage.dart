import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';
import './search.dart';
import 'package:cardi_app/models/pest.dart';
import 'package:url_launcher/url_launcher.dart';
import './login.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //place more multiple widgets into a parent called Container
    Widget titleSection = new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [const Color(0xFFE8F5E9), const Color(0xFF43A047) ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.3,1.1],
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
                        child:  new Text("An application to help small-farmer producers and stakeholders to have access to any information concerning the different types of coconut pests and diseases risk mitigation control methods used in the Coconut Industry.",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                            color:Colors.grey[750],
                            fontSize: 20.0)
                            ),
                  ),

                  new ListTile(
                      title: Text ('Updating Regional Coconut Water Safety Standards'),
                    ),
                  RaisedButton(
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.black,
                        splashColor: Colors.green,
                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/07/09/updating-regional-coconut-water-safety-standards/");},
                        child: new Text('Click Here'),
                 ),
                  //
                  new ListTile(
                    title: Text ('Challenges in the Coconut Industry and Strategies to Overcome Them'),
                  ),
                  RaisedButton(
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.black,
                        splashColor: Colors.green,
                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/08/02/challenges-in-the-coconut-industry-and-strategies-to-overcome-them/");},
                        child: new Text('Click Here'),
                 ),
                  //
                  new ListTile(
                    title: Text ('CARDI and Teleios Code Jam 2018'),
                  ),
                  RaisedButton(
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.black,
                        splashColor: Colors.green,
                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/11/29/cardi-and-the-teleios-code-jam-2018");},
                        child: new Text('Click Here'),
                 ),
                  //
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
          new Container(
            child: new Image.asset(
                'images/coconutFarm.jpg',
                fit: BoxFit.fill
            ),
          ),
          //We can add more widgets below
          titleSection,
        ]
      )
      );
  }//end build method


  _launchURL(url) async {
  //String url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}

String mainProfilePicture = "url";


class RootDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Drawer(
        child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                //for this part, we have to use Google's authentication system
                accountName: new Text("User"),
                accountEmail: new Text("User1@gmail.com"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage("url"),
                  )
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage("https://wallpapercave.com/wp/wp2557267.png")
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.home),
                  title: Text('Home', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => AboutUs()),
                    );
                  }),
              new Divider(),
              ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('Pests', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => PestsPage()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('Diseases', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DiseasesPage()),
                    );
                  }),
              new Divider(),
              ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Chat', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => Chat()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Contact Us', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => ContactUs()),
                    );
                  }),
              new Divider(),
              ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Sign out', textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                    );
                  }),
            ])
    );
  }
}


class RootScaffold extends StatelessWidget{

  final Widget body;
  final String title;
  final Widget search;

  RootScaffold({this.body,this.title, this.search});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text (title),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Search()),
                );
              }
           ),
        ],
      ),
      drawer: new RootDrawer(),
      body: body,
    );
  }
}