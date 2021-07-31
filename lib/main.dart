import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/importBook.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initLink();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}
