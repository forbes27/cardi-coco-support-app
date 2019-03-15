import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import './aboutus.dart';
import './pests.dart';
import './diseases.dart';
import './chat.dart';
import './contact-us.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:cardi_app/models/board.dart';
import 'package:url_launcher/url_launcher.dart';
import './homepage.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> {

  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  void initState() {
    super.initState();

    board = Board("", "");
    databaseReference = database.reference().child("community_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: "Community Board",
        body: Column(
            children: <Widget>[
              Flexible(
                flex: 0,
                child: Center(
                    child: Form(
                        key: formKey, //essentially a controller for the key
                        child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.subject),
                                title: TextFormField(
                                  initialValue: "",
                                  onSaved: (val) => board.subject = val,
                                  //onSaved determines what form.save() does
                                  validator: (val) => val == "" ? val : null,
                                ),
                              ),
                              ListTile(
                                  leading: Icon(Icons.message),
                                  title: TextFormField(
                                    initialValue: "",
                                    onSaved: (val) => board.body = val,
                                    validator: (val) => val == "" ? val : null,
                                  )
                              ),

                              FlatButton(
                                  child: Text("Post"),
                                  color: Colors.greenAccent,
                                  onPressed: () {
                                    handleSubmit();
                                  }
                              )

                            ]
                        )
                    )
                ),
              ),
              Flexible(
                  child: FirebaseAnimatedList(
                      query: databaseReference,
                      itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.greenAccent,
                            ),
                            title: Text(boardMessages[index].subject),
                            subtitle: Text(boardMessages[index].body),
                          ),
                        );
                      }
                  )

              ),
            ]
        )
    );
  }



  void _onEntryAdded(Event event) {
    setState(() { //anytime an entry is added, it is added to community board and the UI is rebuilt to show the updated board/update state
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey
        .currentState; //saves the current state of the form
    if (form.validate()) { //validation checks if form has data
      form.save();
      form.reset();
      //save form data to the database

      databaseReference.push().set(
          board.toJson()); //push creates unique key for entry in firebase
    }
  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.key == event.snapshot.key;
    });

    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] =
          Board.fromSnapshot(event.snapshot);
    });
  }
}
