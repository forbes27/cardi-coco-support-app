import 'package:flutter/material.dart';
import './ui/splash.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //forcing the application to be displayed in portrait mode
    return MaterialApp(
      title: 'Coconuts Support Center',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new SplashPage()
    );
  }
}

