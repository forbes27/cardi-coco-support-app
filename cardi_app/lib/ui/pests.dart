import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cardi_app/models/pest.dart';
import 'homepage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:cardi_app/model/board.dart';
import 'package:cardi_app/models/user.dart';
import 'package:flutter_tts/flutter_tts.dart';


class PestDetail extends StatelessWidget{

  final Pest pest;
  final User currentUser;
  FlutterTts fluttertts = new FlutterTts();

  PestDetail({this.pest, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: pest.key,
      currentUser: currentUser,
      body: new ListView(
        children: <Widget>[
          //design part for the picture of the pests
          ClipRRect(
            borderRadius: new BorderRadius.circular(10.0),
            child: new Image.network(
              pest.pic,
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                    "Description", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)
                  ),
                ),

                RaisedButton(
                  padding: const EdgeInsets.all(0.0),
                  color: Colors.white,
                  textColor: Colors.black,
                  splashColor: Colors.green,
                  onPressed: (){_speak("${pest.description}");},
                  child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                 ),

                 new Text(pest.description,
                    textAlign: TextAlign.start,
                    style: new TextStyle(color:Colors.grey[800], fontSize: 20.0)
                  ),
              ],
            ),
          ),

          //design part for the symptoms of the pests
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: new Text(
                      "Symptoms", style: new TextStyle(
                      color:Colors.grey[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)
                    ),
                  ),

                  RaisedButton(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    textColor: Colors.black,
                    splashColor: Colors.green,
                    onPressed: (){_speak("${pest.symptom}");},
                    child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                  ),

                  new Text(pest.symptom,
                    textAlign: TextAlign.start,
                      style: new TextStyle(color:Colors.grey[800], fontSize: 20.0)
                  ),
                ],
            ),
          ),

          //design part for the mitigation controls of the pests
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                  "How to deal with this Pest", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)
                  ),
                ),

                RaisedButton(
                  padding: const EdgeInsets.all(0.0),
                  color: Colors.white,
                  textColor: Colors.black,
                  splashColor: Colors.green,
                  onPressed: (){_speak("${pest.mitigation}");},
                  child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                 ),

                new Text(pest.mitigation,
                  textAlign: TextAlign.start,
                    style: new TextStyle(color:Colors.grey[800], fontSize: 20.0)
                ),
                ],
              ),
            ),
           ],
         ),
      );
  }

  Future _speak(str) async{
    var result = await fluttertts.speak("${str}");
  }
}

class PestsPage extends StatefulWidget {

  final User currentUser;
  PestsPage({Key key, this.currentUser}): super(key: key);

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
    currentUser: widget.currentUser,

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
                      MaterialPageRoute(builder: (context) => PestDetail(pest: pestList[index], currentUser: widget.currentUser)),
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
