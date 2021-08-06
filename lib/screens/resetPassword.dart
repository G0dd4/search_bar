import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email ='';
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
        title: Text('Réinitialisation du mot de passe',
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color(0xFF505050),)
        ),
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
                      decoration: const InputDecoration(
                        //hintText: 'Adresse mail',
                        labelText: 'Adresse mail',
                      ),
                      validator: (val) => val!.isEmpty ? 'Entrez votre adresse mail' : null,
                      onChanged: (val){
                        setState(() => email = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextButton(
                      child: Text('Réinitialisation du mot de passe',
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
                          dynamic result = await _auth.resetPassword(email);
                          if (result == null) {
                            setState(() {
                              error = 'Adresse mail incorrect';
                            });
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
}