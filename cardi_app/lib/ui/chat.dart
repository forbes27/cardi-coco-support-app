import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:cardi_app/models/user.dart';
import 'package:cardi_app/models/message.dart';
import 'package:url_launcher/url_launcher.dart';
import './homepage.dart';
import 'dart:convert';

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
        currentUser: widget.currentUser,
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
  final TextEditingController _textController = new TextEditingController();
  Message message;
  List<Message> messageList = List();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  String hash;

  void initState() {
    super.initState();
    message = Message(widget.currentUser.id,widget.target.id,"");
    databaseReference = database.reference().child("messages");
    hash = (widget.currentUser.id.hashCode+widget.target.id.hashCode).toString();
    databaseReference = databaseReference.child(hash);
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);

  }

  @override
  Widget build(BuildContext context) {
    return new RootScaffold(
      title: "${widget.target.displayName}",
        currentUser: widget.currentUser,
        body: Column(
             children: <Widget>[
               new Flexible(
                   child: FirebaseAnimatedList(
                       query: database.reference().child("messages").child(hash),
                       itemBuilder: (_, DataSnapshot snapshot,
                           Animation<double> animation, int index) {
                         if (messageList[index].sender ==
                             widget.currentUser.id) {
                           return Padding(
                             padding: EdgeInsets.fromLTRB(5.0, 4.0, 40.0, 0.0),
                             child: new Card(
                               child: ListTile(
                                 leading: CircleAvatar(
                                     backgroundImage: new NetworkImage(
                                         "${widget.currentUser.photoUrl}")
                                 ),
                                 title: Text(messageList[index].message),
                               ),
                               color: Colors.lightGreen,
                             ),
                           );
                         } else {
                           return Padding(
                             padding: EdgeInsets.fromLTRB(66.0, 4.0, 16.0, 0.0),
                             child: new Card(
                               child: ListTile(
                                 leading: CircleAvatar(
                                     backgroundImage: new NetworkImage(
                                         "${widget.target.photoUrl}")
                                 ),
                                 title: Text(messageList[index].message),
                               ),
                               color: Colors.greenAccent,
                             ),
                           );
                         }
                       }
                   )
               ),
               Container(
                 decoration: new BoxDecoration(
                     border: new Border.all(width: 2, color: Colors.green),
                   borderRadius: BorderRadius.all(Radius.circular(25.0))
               ),
                    child: Row(
                      children: <Widget>[
                     new Container(
                       margin: new EdgeInsets.symmetric(horizontal: 4.0),
                       child: new IconButton(
                           icon: new Icon(Icons.camera_enhance),
                           onPressed: () => _handleSubmitted(_textController.text)),
                     ),
                     new Flexible(
                       child: new TextField(
                         controller: _textController,
                         onSubmitted: _handleSubmitted,
                         decoration: new InputDecoration.collapsed(
                             hintText: "Send a message", ),
                       ),
                     ),
                     new Container(
                       margin: new EdgeInsets.symmetric(horizontal: 4.0),
                       child: new IconButton(
                           icon: new Icon(Icons.send),
                           onPressed: () => _handleSubmitted(_textController.text)),
                     ),
                   ],
                 ),
               ),
//              Form(
//                  key: formKey,
//                child: TextFormField(
//                  onSaved: (val) => message.message = val,
//                                    //onSaved determines what form.save() does
//                                    validator: (val) => val == "" ? val : null,
//                  ),
//                ),

//             new Container(
//               child: new FlatButton(
//                   //margin: new EdgeInsets.symmetric(horizontal: 4.0),
//                   child: new IconButton(
//                     icon: new Icon(Icons.send),
//                   ),
//                   onPressed: () {
//                     _handleSubmitted(_textController.text);
//                     }
//                   ),
//             ),


             ]
        )
    );
  }
  void _handleSubmitted(String text) {
    message.message=_textController.text;
    databaseReference.push().set(
        message.toJson()); //push creates unique key for entry in firebase
    _textController.clear();
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

//    void handleSubmit() {
//    final FormState form = formKey
//        .currentState; //saves the current state of the form
//    if (form.validate()) { //validation checks if form has data
//      form.save();
//      form.reset();
//      //save form data to the database
//      databaseReference.push().set(
//          message.toJson()); //push creates unique key for entry in firebase
//    }
//  }

//    Future<List<Message>> _getMessages() async{
//      var data = await http.get("https://cardi-coco-support-app.firebaseio.com/messages.json");
//      var jsonData = json.decode(data.body);
//      print(jsonData);
//      List<Message> messages = [];
//
//      for (var u in jsonData){
//        Message msg = Message.ver2(u["id"], u["hash"], u["message"], u["receiver"], u["sender"]);
//        messages.add(msg);
//      }
//      print(messages.length);
//      return messages;
//
//    }
}




//
//FutureBuilder(
//                  future: _getMessages(),
//                  builder: (BuildContext context, AsyncSnapshot snapshot) {
//                    if (snapshot.data == null) {
//                      return Container(
//                          child: Center(
//                              child: Text("Loading...")
//                          )
//                      );
//                    } else {
//                      return ListView.builder(itemCount: snapshot.data.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          return ListTile(
//                            title: Text(snapshot.data[index].message),
//                          );
//                        },
//                      );
//                    }
//                  }
//
//              ),