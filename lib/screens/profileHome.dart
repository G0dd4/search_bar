import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/models/userData.dart';
import 'package:search_bar/screens/profileMainPage.dart';
import 'package:search_bar/services/bddUsers.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: UserData(email: '', password: '', pseudo: '', uid: '', firstName: '', lastName: '') ,
      value: BddUser().userData,
      child: MaterialApp(debugShowCheckedModeBanner: false,
          home: ProfileMain()),
    );
  }

}