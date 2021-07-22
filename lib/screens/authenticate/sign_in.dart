import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password ='';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to ...'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Entrez une adresse mail' : null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height:20.0),
              TextFormField(
                obscureText: true,
                  validator: (val) => val!.isEmpty ? 'Entrez un mot de passe' : null,
                  onChanged: (val){
                    setState(() => password = val);
                  }
              ),
              SizedBox(height:20.0),
              RaisedButton(
                child: Text('Connexion',
                  style: TextStyle(color: Colors.white),
              ),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email,password);
                    if(result == null){
                      setState(() => error = 'Erreur');
                  }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            ],
          ),
      ),
      ),
    );
  }
}
