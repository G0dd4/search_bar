import 'package:flutter/material.dart';
import 'package:search_bar/screens/mainPage.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MainPage(streamController.stream),
    );
  }
}


