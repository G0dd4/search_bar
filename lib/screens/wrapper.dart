import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/authenticate/authenticate.dart';
import '../screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    print(user);


    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
