import 'package:flutter/material.dart';
import './ui/splash.dart';
import './ui/login.dart';
import './ui/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARDI Coconut Support Center',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: new HomePage(
      )
    );
  }
}

