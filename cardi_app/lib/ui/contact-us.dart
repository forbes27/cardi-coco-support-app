import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cardi_app/models/user.dart';

class ContactUs extends StatefulWidget {
  final User currentUser;
  ContactUs({Key key, this.currentUser}): super(key: key);

  @override
   State<ContactUs> createState() => _ContactUsState();

}

class _ContactUsState extends State<ContactUs> {
  // This widget is the root of your application.

  GoogleMapController myController;

    static final CameraPosition _cardiLocation = CameraPosition(
    target: LatLng(10.6435963, -61.4044734),
    zoom: 14.4746,
  );



  @override
  Widget build(BuildContext context) {
    return RootScaffold(
        title: "Contact Us",
        currentUser: widget.currentUser,
        body: new SingleChildScrollView(

      ),
    );
  }

}


