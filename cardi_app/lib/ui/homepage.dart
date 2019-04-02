import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';
import './search.dart';
import 'package:cardi_app/models/pest.dart';
import 'package:url_launcher/url_launcher.dart';
import './signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cardi_app/models/user.dart';


class HomePage extends StatelessWidget {
  final User currentUser;

  HomePage({Key key, this.currentUser}) : super(key: key);
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

        ]
      ),
    );

    return new RootScaffold(
      title: "Home",
      body: new ListView(
        children: <Widget>[
          //We can add more widgets below
          titleSection,
        ]
      ),currentUser: currentUser,
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
  final GoogleSignIn _gSignIn = new GoogleSignIn();
  final User currentUser;

 RootDrawer({Key key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return new Drawer(
        child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                //for this part, we have to use Google's authentication system
                accountName: new Text("${currentUser.displayName}"),
                accountEmail: new Text("${currentUser.email}"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage("${currentUser.photoUrl}"),
                  )
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage("https://ak0.picdn.net/shutterstock/videos/343000/thumb/1.jpg")
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
                      MaterialPageRoute(builder: (BuildContext context) => Chat(currentUser: currentUser)),
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
                    _gSignIn.signOut();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => SigninPage()),
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
  final User currentUser;

  RootScaffold({this.body,this.title, this.search, this.currentUser});

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
      drawer: new RootDrawer(currentUser: currentUser),
      body: body,
    );
  }
}