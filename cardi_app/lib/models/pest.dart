import 'package:firebase_database/firebase_database.dart';

class Pest {
  String key;
  String description;
  String mitigation;

  Pest(this.description, this.mitigation);

  Pest.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        description = snapshot.value["description"],
        mitigation = snapshot.value["mitigation"];

}