import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_bar/models/userData.dart';
import 'package:search_bar/screens/profileHome.dart';
import 'package:search_bar/services/bddUsers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSettings extends StatefulWidget {
  const UserDataSettings({Key? key}) : super(key: key);

  @override
  _UserDataSettingsState createState() => _UserDataSettingsState();
}


class _UserDataSettingsState extends State<UserDataSettings> {

  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = false;
  String email ='';
  String password ='';
  String lastName='';
  String firstName='';
  String pseudo='';


  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final String uid = userData.uid;
    String currentEmail =userData.email;
    String currentPassword =userData.password;
    String currentLastName=userData.lastName;
    String currentFirstName=userData.firstName;
    String currentPseudo=userData.pseudo;


    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Color(0xFF505050)),
          onPressed: (){
              Navigator.pop(context);
          }
        ),
        backgroundColor: Color(0xFFFCFCFC),
        elevation: 0.0,
        title: Text('Paramètres du profil',
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color(0xFF505050),)
        ),
        actions: <Widget>[
         IconButton(
            icon: Icon(Icons.edit,color: Color(0xFF505050)),
            onPressed: (){
              setState(() => _isEnabled = !_isEnabled);
              print(_isEnabled);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:20.0),
                  TextFormField(
                    enabled: _isEnabled,
                    initialValue: currentLastName,
                      decoration: const InputDecoration(
                        labelText: 'Nom',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez votre nom' : null,
                      onChanged: (val){
                        setState(() => lastName = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      enabled: _isEnabled,
                      initialValue: currentFirstName,
                      decoration: const InputDecoration(
                        labelText: 'Prénom',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez votre prénom' : null,
                      onChanged: (val){
                        setState(() => firstName = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      enabled: _isEnabled,
                      initialValue: currentPseudo,
                      decoration: const InputDecoration(
                        labelText: 'Pseudo',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez un pseudo' : null,
                      onChanged: (val){
                        setState(() => pseudo = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      enabled: _isEnabled,
                      initialValue: currentEmail,
                      decoration: const InputDecoration(
                        //hintText: 'Adresse mail',
                        labelText: 'Adresse mail',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez une adresse mail' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      enabled: _isEnabled,
                      initialValue: currentPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        //hintText: 'Mot de passe',
                        labelText: 'Mot de passe',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez un mot de passe' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextButton(
                      child: Text('Valider',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),
                        ),
                        backgroundColor: _isEnabled ? MaterialStateProperty.all(Colors.green) : MaterialStateProperty.all(Color(0xFF9B9B9B)),
                      ),
                      onPressed: () async{
                        print(email);
                        print(firstName);
                        if(_isEnabled) {
                          if (_formKey.currentState!.validate()) {
                            /*showDialog(
                              context: context,
                              builder: (BuildContext context) => _popUp(context),
                            );*/
                              await BddUser(uid: uid).updateUserData(
                                  (lastName == '') ? currentLastName : lastName,
                                  (firstName == '') ? currentFirstName : firstName,
                                  (email == '') ? currentEmail : email,
                                  (password == '') ? currentPassword : password,
                                  (pseudo == '') ? currentPseudo : pseudo);
                              Navigator.pushAndRemoveUntil(context,
                                  customPageRouteBuilder(Profile()), (
                                      _) => false);
                          }
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*Widget _popUp(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final String uid = userData.uid;
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Voulez-vous sauvegarder les modifications ?"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () async {
            await BddUser(uid: uid).updateUserData(lastName,firstName,email,password,pseudo);
            *//*await BddUser(uid: uid).updateLastName(lastName);
            await BddUser(uid: uid).updateFirstName(firstName);
            await BddUser(uid: uid).updatePassword(password);
            await BddUser(uid: uid).updatePseudo(pseudo);*//*
            Navigator.pushAndRemoveUntil(context,
                customPageRouteBuilder(Profile()), (_) => false);
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
  }*/

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

