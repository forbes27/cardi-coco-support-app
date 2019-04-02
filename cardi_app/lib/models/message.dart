import 'package:firebase_database/firebase_database.dart';
class Message {
  String id;
  String sender;
  String receiver;
  String message;

  Message(this.sender, this.receiver, this.message);

   Message.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        sender = snapshot.value["sender"],
        receiver = snapshot.value["receiver"],
        message = snapshot.value["message"];

   toJson(){
    return {
      "sender": sender,
      "receiver": receiver,
      "message": message
    };
  }
}