import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../root_page.dart';
import 'splash.dart';
import 'homepage.dart';
import 'dart:collection';
import 'package:cardi_app/models/user.dart';

class SigninPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
 _SigninPageState createState() => new _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _gSignIn = new GoogleSignIn();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('images/coconuts.jpg'), fit: BoxFit.fill,),
            ),
          ),

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(bottom: 300.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: new Image.asset(
                          'images/cardilogo.png',
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),

                      Text(
                        "Coconuts Support Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //Row for login button
          new Container(
            padding: new EdgeInsets.only(top: 300.0),
            margin: new EdgeInsets.all(50.0),
            child: new Row(
              children: <Widget>[
                new MaterialButton(
                  height: 40.0,
                  minWidth: 250.0,
                  color: Colors.white,
                  textColor: Colors.black,
                  splashColor: Colors.green,
                  child: new Text("Login/Register",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),

                  onPressed: ()=>_googleSignin(),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _googleSignin() async {

    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
        databaseReference = database.reference().child("users");

//an alternative option is to use push() which autogenerates an ID in Firebase and put google uid as a field in that nested list
    databaseReference.child(user.uid);
    databaseReference.child(user.uid).child("displayName").set(user.displayName);
    databaseReference.child(user.uid).child("email").set(user.email);
    databaseReference.child(user.uid).child("photoUrl").set(user.photoUrl);

    User currentUser = User(user.uid, user.displayName, user.email, user.photoUrl);

    print("User is ${user.uid}");
    print("User is ${user.displayName}");
    print("User is ${user.email}");
    print("User is ${user.photoUrl}");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(currentUser: currentUser,
                )),
      );
  }

  Future<String> currentUser() async{ //Asynchronously gets current user or null if there is none //https://www.youtube.com/watch?v=aaKef60iuy8
    FirebaseUser user = await FirebaseAuth.instance.currentUser();//returns user if they have successfully signed in or registered
    return user.uid; //Returns null if unsuccessful or if app is closed and restarted
  }
}

