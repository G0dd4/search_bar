import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/models/userData.dart';
import 'package:search_bar/screens/userDataSettings.dart';
import 'package:search_bar/screens/wrapper.dart';
import 'package:search_bar/services/auth.dart';
import 'package:search_bar/widget/bottomBar.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);

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
              //Text('Utilisateur: ' + email),
              // Bouton de déconnexion
              Expanded(
                child:ListView(
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                            leading: Icon(Icons.manage_accounts, color: Color(0xFF9B9B9B)),
                            title: Text(userData.lastName + ' ' + userData.firstName),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserDataSettings()),
                              );
                            }
                        ),
                        ListTile(
                            title: Text('...'),
                            onTap: (){}
                        ),
                        ListTile(
                            title: Text('...'),
                            onTap: (){}
                        ),
                        ListTile(
                            leading: Icon(Icons.settings, color: Color(0xFF9B9B9B)),
                            title: Text('Paramètres'),
                            onTap: (){}
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: Color(0xFF9B9B9B)),
                          title: Text('Déconnexion'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _popUp(context),
                            );
                          },
                        ),
                      ]
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(current: 2),
    );
  }

  Widget _popUp(BuildContext context) {
    final AuthService _auth = AuthService();
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Etes-vous sûr de vouloir vous déconnecter ?"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushAndRemoveUntil(context,
                customPageRouteBuilder(Wrapper()), (_) => false);
          },
          child: const Text('Oui', style: TextStyle(color: Colors.blue)),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Non', style: TextStyle(color: Colors.blue)),
        ),
      ],
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
