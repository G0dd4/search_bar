import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/screens/wrapper.dart';
import '../widget/bottomBar.dart';
import 'package:search_bar/services/auth.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    String email = user!.email.toString();
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Text(
                'Profil',
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Color(0xFF505050),
                ),
              ),
              SizedBox(height:20.0),
              Text('Utilisateur: ' + email),
              SizedBox(height:20.0),
              // Bouton de déconnexion
              TextButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      customPageRouteBuilder(Wrapper()), (_) => false);
                },
                /*async {
                  await _auth.signOut();
                },*/
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(current: 2),
    );
  }

  PageRouteBuilder customPageRouteBuilder(Widget pageToGo) {
    return PageRouteBuilder(
      transitionDuration: Duration(microseconds: 0),
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secanimation,
          Widget child,
          ) {
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secanimation,
          ) {
        return pageToGo;
      },
    );
  }
}