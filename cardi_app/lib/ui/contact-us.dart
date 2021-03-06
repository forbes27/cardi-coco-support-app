import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cardi_app/models/user.dart';

class ContactUs extends StatefulWidget {
  final User currentUser;
  ContactUs({Key key, this.currentUser}): super(key: key);
  @override
   State<ContactUs> createState() => _ContactUsState();

}

class _ContactUsState extends State<ContactUs> {
  // This widget is the root of your application.
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(10.643634, -61.402275),
        infoWindowText: InfoWindowText(
          'Caribbean Agricultural Research & Development Insititute.',
          'University of the West Indies, St. Augustine Campus'
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
        title: "Contact Us",
        currentUser: widget.currentUser,
        body: new SingleChildScrollView(child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,

                    options: GoogleMapOptions(
                      compassEnabled: true,
                      cameraPosition: CameraPosition(
                        target: LatLng(10.643634, -61.402275),
                        zoom: 15.0,
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 20.0, 140.0, 0.0),
                  child: new Text(
                      "CARDI Trinidad \n"
                      "University Campus \n"
                      "St. Augustine \n"
                      "Trinidad & Tobago \n"
                      "Phone: (868) 645-1205 \n"
                      "Fax: (868) 645-1208",
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 120.0, 8.0),
                  child: new Text(
                      "Email: jpeterson@cardi.org", textAlign: TextAlign.left, style: TextStyle(color: Colors.blue, fontSize: 18.0, decoration: TextDecoration.underline )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 20.0, 110.0, 0.0),
                  child: new Text(
                      "CARDI Tobago \n"
                      "Blenheim Research Station \n"
                      "Mount St. George \n"
                      "Trinidad & Tobago \n"
                      "Phone: (868) 660-2237 \n"
                      "Fax: (868) 660-2237", textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 110.0, 8.0),
                  child: new Text("Email: carditgo@gmail.com ", textAlign: TextAlign.left, style: TextStyle(color: Colors.blue, fontSize: 18.0, decoration: TextDecoration.underline)),
                )
              ])
      ),
    );
  }
}
