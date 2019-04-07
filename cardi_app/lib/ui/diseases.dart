import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cardi_app/models/disease.dart';
import 'homepage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cardi_app/models/user.dart';


class DiseaseDetail extends StatelessWidget{
  final Disease disease;
  final User currentUser;

  DiseaseDetail({this.disease, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: disease.key,
      currentUser: currentUser,
      body: new ListView(
        children: <Widget>[
          //We can add more widgets below
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
                children: <Widget>[ new Text(
                    "Description:", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 25.0,
                fontWeight: FontWeight.bold)
                ), new Text(disease.description,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        color:Colors.grey[800],
                        fontSize: 20.0)
                ),

                ]
            ),
          ),

          //design part for the mitigation controls of the diseases
          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
                children: <Widget>[ new Text(
                    "Symptoms:", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)
                ), new Text(disease.symptom,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        color:Colors.grey[800],
                        fontSize: 20.0)
                ),

                ]
            ),
          ),

          new Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),//top, bottom, left, right
            child: Column(
                children: <Widget>[ new Text(
                    "How to deal with this Disease:", style: new TextStyle(
                    color:Colors.grey[800],
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)
                ), new Text(disease.mitigation,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        color:Colors.grey[800],
                        fontSize: 20.0,
                    )
                ),

                ]
            ),
          ),
        ],
      ),
    );
  }
}

class DiseasesPage extends StatefulWidget {
  final User currentUser;
  DiseasesPage({Key key, this.currentUser}): super(key: key);

  @override
  _DiseasesPageState createState() => new _DiseasesPageState();

}

class _DiseasesPageState extends State<DiseasesPage> {
  Disease diseases;
  List<Disease> diseaseList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    //diseases = Disease("", "");
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
    setState(() { //anytime an entry is added, it is added to community board and the UI is rebuilt to show the updated board/update state
      diseaseList.add(Disease.fromSnapshot(event.snapshot));
    });
  }


  void _onEntryChanged(Event event) {
    var oldEntry = diseaseList.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.key == event.snapshot.key;
    });

    setState(() {
      diseaseList[diseaseList.indexOf(oldEntry)] =
          Disease.fromSnapshot(event.snapshot);
    });
  }
}


//Not working yet
//class DiseaseDetail extends StatefulWidget {
//  var value;
//  DiseaseDetail({Key key, this.value}) : super(key: key);
//  @override
//  _DiseaseDetailState createState() => new _DiseaseDetailState();
//}
//class _DiseaseDetailState extends State<DiseaseDetail> {
//  @override
//  Widget build(BuildContext context) {
//    return new RootScaffold(
//      title: "${widget.value.key}",
//      body: new Text("${widget.value.key}"),
//    );
//  }
//}

