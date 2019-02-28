import 'package:firebase_database/firebase_database.dart';

class Pest {
  String key;
  String description;
  String mitigation;
  String pic;
  String symptom;


  Pest(this.description, this.mitigation, this.pic, this.symptom);

  Pest.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        description = snapshot.value["description"],
        pic = snapshot.value["pic"],
        mitigation = snapshot.value["mitigation"],
        symptom = snapshot.value["symptom"];

}