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
        body: new Center(
      child: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 400.0,
                  width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: (controller){
                      setState((){
                        myController = controller;
                        myController.addMarker(
                          MarkerOptions(
                            position: LatLng(10.6435963, -61.4044734),
                          ),
                        );
                      });
                    },
                    options: GoogleMapOptions(
                      compassEnabled: true,
                      cameraPosition: CameraPosition(
                        target: LatLng(10.6435963, -61.4044734),
                        zoom: 15.0,
                      ),
                    ),
                  )
                )
              ])
      ),
    ));
  }

}


