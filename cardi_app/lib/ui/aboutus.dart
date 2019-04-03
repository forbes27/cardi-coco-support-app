import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:cardi_app/models/user.dart';

class AboutUs extends StatelessWidget {

  final User currentUser;
  AboutUs({Key key, this.currentUser}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
        title: "About Us",
        currentUser: currentUser,
        body: new Center(
      child: new SingleChildScrollView(

      ),
    ));
  }
}
