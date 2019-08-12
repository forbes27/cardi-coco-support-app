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
        child: new SingleChildScrollView(child: new Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: new BorderRadius.circular(10.0),
                  child: new Image.asset('images/CARDI-ITC.jpg',
                    fit: BoxFit.fill,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: new Text(
                        "Since 1975, CARDI was established by the heads of Governments of CARICOM to improve the quality of lives of the people of the caribbean through perpetual agricultural research."
                        " \n\nWith the use of technology, it has become more effective to share or distribute critical information that is readily accessible to small-holder farmers and people of the Caribbean.\n\n"
                        "Coconuts Support Centre is a collaborative work between CARDI and ITC (International Trade Center).",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: new Text(
                      "\nObjectives\n", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[800], fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                new Text(
                      "  - To access the need for mobile device application in the Coconut Industry for the Caribbean \n\n"
                      "  - To increase access to coconut pest and disease control methods for small-holder farmers and stakeholders \n\n"
                      "  - To assist with decision-making about coconut cultivation \n",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style: new TextStyle(
                      fontSize: 20),
                ),
              ],
        ),
      ),
    ));
  }
}

