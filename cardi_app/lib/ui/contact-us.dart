import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class ContactUs extends StatefulWidget {

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
        body: new SingleChildScrollView(

      ),
    );
  }

}


