import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../root_page.dart';
import './homepage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _gSignIn = new GoogleSignIn();


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new LoginPage(),
    );
  }

}

class LoginPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
 _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  child: FlatButton(
                    color: Colors.greenAccent,
                    child: new Text("Google Sign-in"),
                    onPressed: () => _googleSignin(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.greenAccent,
                    child: Text("Signin with Email"),
                    onPressed: () {},
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.greenAccent,
                    child: new Text("Create Account"),
                    onPressed: () => _createUser(),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.greenAccent,
                    child: new Text("Signout"),
                    onPressed: () => _logout(),
                  ),
                ),


              ]
          ),
        )
    );
  }

  Future<FirebaseUser> _googleSignin() async {
    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    print("User is ${user.displayName}");

    return user;
  }

  Future _createUser() async {
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: "calida@gmail.com", password: "test123")
        .then((user) {
      print("User Created ${user.displayName}");
      print("Email: ${user.email}");
    });
  }

  _logout() {
    setState(() {
      _gSignIn.signOut();
    });
  }

  Future<String> currentUser() async{ //Asynchronously gets current user or null if there is none //https://www.youtube.com/watch?v=aaKef60iuy8
    FirebaseUser user = await FirebaseAuth.instance.currentUser();//returns user if they have successfully signed in or registered
    return user.uid; //Returns null if unsuccessful or if app is closed and restarted
  }
}

