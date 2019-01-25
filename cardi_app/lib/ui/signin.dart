import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                child: new Text("Google Sign-in"),
                onPressed: () => _googleSignin(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Text("Signin with Email"),
                onPressed: () {},
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: new Text("Create Account"),
                onPressed: () {},
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

}

