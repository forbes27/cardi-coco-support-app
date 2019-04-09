import 'package:firebase_database/firebase_database.dart';
class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  User(this.id, this.displayName, this.email, this.photoUrl);


   User.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        photoUrl = snapshot.value["photoUrl"],
        email = snapshot.value["email"],
        displayName = snapshot.value["displayName"];
}