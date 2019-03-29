import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cardi_app/models/pest.dart';
import 'homepage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:cardi_app/model/board.dart';


class PestDetail extends StatelessWidget{

  final String title;
  final String description;
  final String pic;
  final String mitigation;
  final String symptom;

  PestDetail({this.title, this.description, this.symptom, this.mitigation, this.pic, });

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: title,
      body: new ListView(
        children: <Widget>[
          //We can add more widgets below
          //design part for the picture of the pests
          ClipRRect(
            borderRadius: new BorderRadius.circular(10.0),
            child: new Image.network(
              pic,
              height: 300,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),

          //design part for the description of the pests
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
              children: <Widget>[ new Text(
                "Description", style: new TextStyle(
                  color:Colors.grey[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)
              ), new Text(description,
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                      color:Colors.grey[800],
                      fontSize: 20.0)
              ),

    ]
            ),
          ),

          //design part for the symptoms of the pests
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
                children: <Widget>[ new Text(
                    "Symptoms", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)
                ), new Text(symptom,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        color:Colors.grey[800],
                        fontSize: 20.0)
                ),

                ]
            ),
          ),

          //design part for the mitigation controls of the pests
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
              children: <Widget>[ new Text(
                "How to deal with this Pest", style: new TextStyle(
                  color:Colors.grey[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)
              ), new Text(mitigation,
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                      color:Colors.grey[800],
                      fontSize: 20.0)
              ),

    ]
            ),
          ),
           ],
         ),
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
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000); //allocating 10MB of storage in cache for pest Data
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
                      MaterialPageRoute(builder: (context) => PestDetail(title: pestList[index].key, pic: pestList[index].pic, description: pestList[index].description, mitigation: pestList[index].mitigation, symptom: pestList[index].symptom)),
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
                            pestList[index].pic, fit: BoxFit.fill,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(pestList[index].key, textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
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

