import 'package:firebase_database/firebase_database.dart';

class Disease {
  String key;
  String description;
  String symptom;
  String mitigation;
  String pic;


  Disease(this.description, this.symptom, this.mitigation, this.pic);

  Disease.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        description = snapshot.value["description"],
        symptom = snapshot.value["symptom"],
        pic = snapshot.value["pic"],
        mitigation = snapshot.value["mitigation"];

}