import 'package:firebase_database/firebase_database.dart';

class Article{

  String id;
  String title;
  String url;
  String thumbnail;

  Article(this.id, this.title, this.url, this.thumbnail);

   Article.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        title = snapshot.value["title"],
        url = snapshot.value["url"],
        thumbnail = snapshot.value["thumbnail"];
}