import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:cardi_app/models/user.dart';
import 'package:cardi_app/models/message.dart';
import 'package:url_launcher/url_launcher.dart';
import './homepage.dart';

class Chat extends StatefulWidget {

  final User currentUser;
  Chat({Key key, this.currentUser}): super(key: key);

  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> {

  List<User> users= List();
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  void initState() {
    super.initState();

    user = User("","", "","");
    databaseReference = database.reference().child("users");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: "Users",
        body: Column(
            children: <Widget>[
              Flexible(
                  child: FirebaseAnimatedList(
                      query: databaseReference,
                      itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: new NetworkImage("${users[index].photoUrl}")
                            ),
                            title: Text(users[index].displayName),
                            subtitle: Text(users[index].email),
                            onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen(target: users[index], currentUser: widget.currentUser)));
            },
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
      users.add(User.fromSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {
    var oldEntry = users.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.id == event.snapshot.key;
    });

    setState(() {
      users[users.indexOf(oldEntry)] =
         User.fromSnapshot(event.snapshot);
    });
  }
}

class ChatScreen extends StatefulWidget {
  final User target;
  final User currentUser;

  ChatScreen({Key key, this.target, this.currentUser}): super(key: key);

  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Message message;
  List<Message> messageList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  void initState() {
    super.initState();
    message = Message(widget.currentUser.id,widget.target.id,"");
    databaseReference = database.reference().child("messages");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: "${widget.target.displayName}",
        body: Column(
             children: <Widget>[
              Form(
        key: formKey,
                child: TextFormField(
                  onSaved: (val) => message.message = val,
                                    //onSaved determines what form.save() does
                                    validator: (val) => val == "" ? val : null,
                ),
              ),
              FlatButton(
                child: Text("Post"),
                color: Colors.green,
                onPressed: () {
                  handleSubmit();
                  }),
              Flexible(
                  child: FirebaseAnimatedList(
                      query: databaseReference,
                      itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                            ),
                            title: Text(messageList[index].message),
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
      messageList.add(Message.fromSnapshot(event.snapshot));
    });
  }


  void _onEntryChanged(Event event) {
    var oldEntry = messageList.singleWhere((entry) { //get old key (firebase key for a post)
      return entry.id == event.snapshot.key;
    });

    setState(() {
      messageList[messageList.indexOf(oldEntry)] =
          Message.fromSnapshot(event.snapshot);
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
          message.toJson()); //push creates unique key for entry in firebase
    }
  }

}
