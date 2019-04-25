import 'package:firebase_database/firebase_database.dart';
class User {

  String id;
  String displayName;
  String email;
  String photoUrl;

  User(this.id, this.displayName, this.email, this.photoUrl); //user constructor

   User.fromSnapshot(DataSnapshot snapshot) : //creates a user object from a data snapshot of the the users in firebase
        id = snapshot.key,
        photoUrl = snapshot.value["photoUrl"],
        email = snapshot.value["email"],
        displayName = snapshot.value["displayName"];
}