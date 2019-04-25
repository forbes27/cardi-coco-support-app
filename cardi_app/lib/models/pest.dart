import 'package:firebase_database/firebase_database.dart';

class Pest {
  String key;
  String description;
  String mitigation;
  String pic;
  String symptom;

  Pest(this.description, this.mitigation, this.pic, this.symptom); //pest constructor

  Pest.fromSnapshot(DataSnapshot snapshot) : //creates a pest object from a data snapshot of the pests in firebase
        key = snapshot.key,
        description = snapshot.value["description"],
        pic = snapshot.value["pic"],
        mitigation = snapshot.value["mitigation"],
        symptom = snapshot.value["symptom"];

}