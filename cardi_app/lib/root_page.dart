import 'package:flutter/material.dart';
import './ui/signin.dart';
import './ui/homepage.dart'; //https://www.youtube.com/watch?v=aaKef60iuy8 PT.4

class RootPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _RootPageState();
  }

}

enum AuthStatus{
  notSignedIn, signedIn
}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  void initState(){ //sets initial state before widgets are built
    super.initState();
  }

  void _signedIn(){
    setState((){
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(authStatus==AuthStatus.notSignedIn)
        return new SigninPage();
    else if(authStatus==AuthStatus.signedIn)
      return new HomePage();

    return new SigninPage();
  }

}