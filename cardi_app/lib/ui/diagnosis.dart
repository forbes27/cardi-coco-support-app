import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:cardi_app/models/user.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';



class Diagnosis extends StatelessWidget {

  final User currentUser;
  Diagnosis({Key key, this.currentUser}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
        title: "About Us",
        currentUser: currentUser,
        body: new Center(
      child: new SingleChildScrollView(child: new Column(
              children: <Widget>[
                RaisedButton(
                    onPressed: () async{
      Future <String> res = await Tflite.loadModel(
          model: "tf_model/model.tflite",
          labels: "tf_model/retrained_labels.txt",
          numThreads: 1
      );
    }
                    },
                    child: Text("Upload"),
                 ),
              ],
        ),
      ),
    ));
  }


  await Tflite.close();

  var recognitions = await Tflite.runModelOnImage(
      path: filepath,
      imageMean: 0.0,
    imageStd: 255.0,
  numResults: 2,
  threshold: 0.2,
  asynch: true
      );

  Future loadModel() async{
    Tflite.close();
    try{
      String res:
      res = await Tflite.loadModel(model: "tf_model/model.tflite", labels: "tf_model/model.tflite");
      print(res);
    } on PlatformException{
      print("Failed to load model.");
    }
}




