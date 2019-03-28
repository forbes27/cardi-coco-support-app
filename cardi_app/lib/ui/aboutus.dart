import 'package:flutter/material.dart';
import './homepage.dart';

class AboutUs extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootScaffold(
        title: "About Us",
        body: new Center(
      child: new SingleChildScrollView(
          child: new Column(
              children: <Widget>[
                new Container(
                  child: new Image.asset(
                      'images/10301.jpg',
                      fit: BoxFit.fill
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: new Text(
                    "       Since 1975, CARDI was established by the heads of Governments of CARICOM to improve the quality of lives of the people "
                        "of the caribbean through perpetual agricultural research. With the use of technology it has become more effective to share or distribute critical "
                        "information that is readily accessible to farmers and people of the caribbean.\n"
                        "       CARDI Coconut Support Centre is a collaborative work between CARDI and ITC(International Trade Center)",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 250.0, 8.0),
                  child: new Text(
                      "OBJECTIVES:", textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline )),
                ),
                new Text(
                  " - To access the need for mobile device application in the coconut industry for the caribbean \n"
                      " - To increase access to coconut pest and disease control methods for farmers and stakeholders \n"
                      " - To assist with decision-making about coconut cultivation.",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                      fontSize: 18),
                ),
              ])
      ),
    ));
  }
}
