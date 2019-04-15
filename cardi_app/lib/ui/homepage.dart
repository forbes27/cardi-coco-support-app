import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';
import './search.dart';
import 'package:url_launcher/url_launcher.dart';
import './signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cardi_app/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cardi_app/models/article.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final User currentUser;
  HomePage({Key key, this.currentUser}): super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  Article article;
  List<Article> articleList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    article = Article("","","","");
    databaseReference = database.reference().child("articles");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }


  Future<List<Article>> _getArticles() async{
    var data = await http.get("https://cardi-coco-support-app.firebaseio.com/articles.json");
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<Article> articles = [];

    for (var u in jsonData){
      Article a = Article.ver2(u["title"], u["url"], u["thumbnail"]);
      articles.add(a);
      print(a.title);
    }
    print(articles.length);
    print(articles);
    return articles;
  }
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
                    child:  new Text("Coconuts Support Centre",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.grey[800],
                            fontSize: 30.0)
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                        child:  new Text("An application to help small-holder farmers and stakeholders to have access to any information concerning the different types of Coconut pests and diseases risk mitigation control methods used in the Coconut Industry.",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                            color:Colors.grey[750],
                            fontSize: 20.0)
                            ),
                  ),
//                  new ListTile(
//                      title: Text ('Updating Regional Coconut Water Safety Standards'),
//                    ),
//                  FloatingActionButton(
//                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/07/09/updating-regional-coconut-water-safety-standards/");},
//                        child: Icon(Icons.info_outline,),
//                 ),
//
//                  new ListTile(
//                    title: Text ('Challenges in the Coconut Industry and Strategies to Overcome Them'),
//                  ),
//                  FloatingActionButton(
//                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/08/02/challenges-in-the-coconut-industry-and-strategies-to-overcome-them/");},
//                        child: Icon(Icons.info_outline,),
//                 ),
//
//                  new ListTile(
//                    title: Text ('CARDI and Teleios Code Jam 2018'),
//                  ),
//                  FloatingActionButton(
//                        onPressed: (){_launchURL("http://www.coconuts.cardi.org/2018/11/29/cardi-and-the-teleios-code-jam-2018");},
//                        child: Icon(Icons.info_outline,),
//                 ),
                ],
              ),
          ),
        ]
      ),
    );

    return new RootScaffold(
      title: "Home",
//      body: new ListView(
//        children: <Widget>[
//          ClipRRect(
//            borderRadius: new BorderRadius.circular(10.0),
//            child: new Image.asset('images/coconuts2.jpg',
//              height: 300,
//              width: 100,
//              fit: BoxFit.fill,
//            ),
//          ),
//          //We can add more widgets below
//          titleSection,
      body: ListView(
      children: <Widget>[
          ClipRRect(
            borderRadius: new BorderRadius.circular(10.0),
            child: new Image.network('http://namfruit.com/wp-content/uploads/2015/10/2.jpg',
              height: 300,
              width: 500,
              fit: BoxFit.cover,
            )
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child:  new Text("Coconuts Support Centre",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Colors.grey[800],
                    fontSize: 30.0)
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 30.0),
            child:  new Text("An application to help farmers have access to information concerning the different types of coconut pests and diseases, and control methods used in the Coconut Industry.",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color:Colors.grey[750],
                    fontSize: 18.0)
            ),
          ),

        new MaterialButton(
                  height: 40.0,
                  minWidth: 300.0,
                  color: Colors.white,
                  textColor: Colors.black,
                  splashColor: Colors.green,
                  child: new Text("Latest Articles...",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),

                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticlePage(currentUser: widget.currentUser)));
                    },

                ),
                    ]
              ),currentUser: widget.currentUser,

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


void _onEntryAdded(Event event) {
    setState(() { //anytime an entry is added, it is added to community board and the UI is rebuilt to show the updated board/update state
      articleList.add(Article.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
    var oldEntry = articleList.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.id== event.snapshot.key;
    });

    setState(() {
      articleList[articleList.indexOf(oldEntry)] =
          Article.fromSnapshot(event.snapshot);
    });
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
                      MaterialPageRoute(builder: (BuildContext context) => HomePage(currentUser: currentUser)),
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
                      MaterialPageRoute(builder: (BuildContext context) => AboutUs(currentUser: currentUser)),
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
                      MaterialPageRoute(builder: (BuildContext context) => PestsPage(currentUser: currentUser)),
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
                      MaterialPageRoute(builder: (BuildContext context) => DiseasesPage(currentUser: currentUser)),
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
                      MaterialPageRoute(builder: (BuildContext context) => ContactUs(currentUser: currentUser)),
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

class ArticlePage extends StatefulWidget {
  final User currentUser;
  ArticlePage({Key key, this.currentUser}): super(key: key);
  @override
  _ArticlePageState createState() => new _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>{
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RootScaffold(
      title: "Articles",
      currentUser: widget.currentUser,
      body: new FutureBuilder(
          future: _getArticles(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData)
              return new Container();
            List<Article> content = snapshot.data;
            return new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: new EdgeInsets.all(2.0),
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    height: 120.0,
                    width: 120.0,
                    alignment: FractionalOffset.center,
                    color: Colors.white10,
                    child: ListTile(
                      title:  Text('${content[index].title}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Container(
                        height: 100.0,
                        width: 100.0,
                        child: Image.network('${content[index].thumbnail}'),
                      ),
                      )

                  );
                }
            );
          }),
    );
  }
  Future<List<Article>> _getArticles() async{
    var data = await http.get("https://cardi-coco-support-app.firebaseio.com/articles.json");
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<Article> articles = [];

    for (var u in jsonData){
      Article a = Article.ver2(u["title"], u["url"], u["thumbnail"]);
      articles.add(a);
      print(a.title);
    }
    print(articles.length);
    print(articles);
    return articles;
  }
}


