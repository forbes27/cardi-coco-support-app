import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cardi_app/models/disease.dart';
import 'homepage.dart';
import 'package:cardi_app/models/user.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class DiseaseDetail extends StatelessWidget{

  final Disease disease;
  final User currentUser;
  FlutterTts flutterTts = new FlutterTts(); //flutter text to speech

  DiseaseDetail({this.disease, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: disease.key,
      currentUser: currentUser,
      body: new ListView(
        children: <Widget>[
          //design part for the picture of the diseases
          ClipRRect(
            borderRadius: new BorderRadius.circular(10.0),
            child: new Image.network(
              disease.pic,
              height: 300,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),

          //design part for the description of the diseases
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
                  onPressed: (){_speak("${disease.description}");},
                  child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                ),

                new Text(disease.description,
                    textAlign: TextAlign.start,
                    style: new TextStyle(color:Colors.grey[800], fontSize: 20.0)
                ),
              ],
            ),
          ),

          //design part for the symptoms of the diseases
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
                  onPressed: (){_speak("${disease.symptom}");},
                  child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                ),

                new Text(disease.symptom,
                    textAlign: TextAlign.start,
                    style: new TextStyle(color:Colors.grey[800], fontSize: 20.0)
                ),
              ],
            ),
          ),

          //design part for the mitigation controls of the diseases
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: new Text(
                      "How to deal with this Disease", style: new TextStyle(
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
                  onPressed: (){_speak("${disease.mitigation}");},
                  child: Image.asset("images/speaker_icon.jpg", height: 35.0,),
                ),

                new Text(disease.mitigation,
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
    var result = await flutterTts.speak("${str}");
  }
}

class DiseasesPage extends StatefulWidget {
  final User currentUser;
  DiseasesPage({Key key, this.currentUser}): super(key: key);
  @override
  _DiseasesPageState createState() => new _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
 Disease pests;
  List<Disease> diseaseList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000); //allocating 10MB of storage in cache for pest Data
    databaseReference = database.reference().child("diseases");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
        title: "Diseases",
        currentUser: widget.currentUser,
        body: StreamBuilder(
            stream: FirebaseDatabase.instance
                .reference()
                .child("diseases")
                .onValue,
            builder: (BuildContext context, AsyncSnapshot<Event> snapshot) { //displays list of diseases in the Firebase tree
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
                            Navigator.push( //navigating to a page displaying an individual disease
                              context,
                              MaterialPageRoute(builder: (context) => DiseaseDetail(disease: diseaseList[index], currentUser: widget.currentUser)),
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
                                    diseaseList[index].pic, fit: BoxFit.fill,
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(diseaseList[index].key, textAlign: TextAlign.center,
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
    setState(() { //anytime a disease is added to firebase, it is added to the diseaseList and the UI is rebuilt to show the updated list
      diseaseList.add(Disease.fromSnapshot(event.snapshot));
    });
  }
  
  void _onEntryChanged(Event event) {
    var oldEntry = diseaseList.singleWhere((entry) { //get old key (firebase key for a disease)
      return entry.key == event.snapshot.key;
    });
    setState(() {
      diseaseList[diseaseList.indexOf(oldEntry)] =
          Disease.fromSnapshot(event.snapshot);
    });
  }
}
