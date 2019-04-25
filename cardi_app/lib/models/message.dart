import 'package:firebase_database/firebase_database.dart';

class Message {
  String id;
  String sender;
  String receiver;
  String message;
  int hash;

  Message(this.sender, this.receiver, this.message);
  Message.ver2(this.id,this.hash, this.message, this.receiver, this.sender); //Construction overloading

   Message.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        sender = snapshot.value["sender"],
        receiver = snapshot.value["receiver"],
        message = snapshot.value["message"],
        hash = snapshot.value["hash"];

   toJson(){
    return {
      "sender": sender,
      "receiver": receiver,
      "message": message,
      "hash": sender.hashCode+receiver.hashCode
    };
  }
}