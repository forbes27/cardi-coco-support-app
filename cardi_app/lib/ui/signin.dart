import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../root_page.dart';
import 'splash.dart';
import 'homepage.dart';
import 'dart:collection';

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
        appBar: new AppBar(
          title: new Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new MaterialButton(
                    height: 40.0,
                    minWidth: 300.0,
                    color: Colors.white,
                    textColor: Colors.black,
                    child: new Text("Google Sign-in",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                      onPressed: () => _googleSignin(),
                ),
                ),
              ]
          ),
        )
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

//an alternative option is to use push() which autogenerates a id in firebase and put google uid as a field in that nested list
    databaseReference.child(user.uid);
    databaseReference.child(user.uid).child("displayName").set(user.displayName);
    databaseReference.child(user.uid).child("email").set(user.email);
    databaseReference.child(user.uid).child("photoUrl").set(user.photoUrl);
    String currentUserId = databaseReference.key;
    print("User is ${user.uid}");
    print("User is ${user.displayName}");
    print("User is ${user.email}");
    print("User is ${user.photoUrl}");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(email: user.email, username: user.displayName, photoUrl: user.photoUrl,
                )),
      );
  }

//  _logout() {
//    setState(() {
//      _gSignIn.signOut();
//    });
//  }

  Future<String> currentUser() async{ //Asynchronously gets current user or null if there is none //https://www.youtube.com/watch?v=aaKef60iuy8
    FirebaseUser user = await FirebaseAuth.instance.currentUser();//returns user if they have successfully signed in or registered
    return user.uid; //Returns null if unsuccessful or if app is closed and restarted
  }
}

