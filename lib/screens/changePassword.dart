import 'package:flutter/material.dart';
import 'package:search_bar/screens/userDataSettings.dart';
import 'package:search_bar/services/auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password ='';
  String newPassword = '';
  String error ='';
  @override
  Widget build(BuildContext context) {
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
        title: Text('Modification des identifiants',
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color(0xFF505050),)
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                        //hintText: 'Mot de passe',
                        labelText: 'Adresse mail',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez votre adresse mail' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                        //hintText: 'Mot de passe',
                        labelText: ' Mot de passe actuel',
                      ),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? 'Entrez votre mot de passe' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                        //hintText: 'Mot de passe',
                        labelText: 'Nouveau mot de passe',
                      ),
                      validator: (val) => val!.length < 6 ? 'Entrez votre nouveau mot de passe' : null,
                      onChanged: (val){
                        setState(() => newPassword = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextButton(
                      child: Text('Modification du mail',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)),

                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.updatePassword(email, password,newPassword);
                          if (result == null) {
                            setState(() {
                              error = 'Adresse mail ou mot de passe incorrect';
                            });
                          }else{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _popUp(context),
                            );
                          }
                        }
                      }),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget _popUp(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Mot de passe modifié"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: (){
            Navigator.pushAndRemoveUntil(context,
                customPageRouteBuilder(UserDataSettings()), (_) => false);
          },
          child: const Text('Ok', style: TextStyle(color: Colors.blue)),
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
