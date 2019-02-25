import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:cardi_app/model/board.dart';
import 'package:cardi_app/models/pest.dart';
import 'homepage.dart';

class Pests extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootScaffold(body: new Center(
      child: new SingleChildScrollView(
          child: new Column(
              children: <Widget>[
                new Text(
                  "Pests!",
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

class PestDetail extends StatelessWidget{

  final String title;
  final String description;

  PestDetail({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: title,
      body: new ListView(
        children: <Widget>[
          new Text(description,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                            color:Colors.grey[750],
                            fontSize: 20.0)
                            ),
          //We can add more widgets below
        ]
      )
      );
  }
}

class PestsPage extends StatefulWidget {

  @override
  _PestsPageState createState() => new _PestsPageState();

}

class _PestsPageState extends State<PestsPage> {
  Pest pests;
  List<Pest> pestList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    //pests = Pest("", "");
    databaseReference = database.reference().child("pests");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
        title: "Pests",


    body: StreamBuilder(
    stream: FirebaseDatabase.instance
        .reference()
        .child("pests")
        .onValue,
    builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
      if (snapshot.hasData) {
        Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
        map.forEach((dynamic, v) => print(v["pic"]));

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: map.values.toList().length,
          padding: EdgeInsets.all(4.0),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PestDetail(title: pestList[index].key, description: pestList[index].description)),
                    );
            },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 18.0 / 11.0,
                        child: Image.network(
                            pestList[index].pic, fit: BoxFit.fitWidth,
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(pestList[index].key, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
              ],
            );
          },
        );
      } else {
        return CircularProgressIndicator();
      }
    })
    );
  }

  void _onEntryAdded(Event event) {
    setState(() { //anytime an entry is added, it is added to community board and the UI is rebuilt to show the updated board/update state
      pestList.add(Pest.fromSnapshot(event.snapshot));
    });
  }


  void _onEntryChanged(Event event) {
    var oldEntry = pestList.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.key == event.snapshot.key;
    });

    setState(() {
      pestList[pestList.indexOf(oldEntry)] =
          Pest.fromSnapshot(event.snapshot);
    });
  }
}


//Not working yet
//class PestDetail extends StatefulWidget {
//  var value;
//  PestDetail({Key key, this.value}) : super(key: key);
//  @override
//  _PestDetailState createState() => new _PestDetailState();
//}
//class _PestDetailState extends State<PestDetail> {
//  @override
//  Widget build(BuildContext context) {
//    return new RootScaffold(
//      title: "${widget.value.key}",
//      body: new Text("${widget.value.key}"),
//    );
//  }
//}

