import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});
  //const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email ='';
  String password ='';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFCFC),
        elevation: 0.0,
        title: Text('Inscription',
        style: TextStyle(
        letterSpacing: 1.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
        color: Color(0xFF505050),)
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person,color: Color(0xFF505050)),
            label: Text('Connexion',
            style:TextStyle(color: Color(0xFF505050))
            ),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height:20.0),
                TextFormField(
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
                    child: Text('Inscription',
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
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
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
      ),
    );
  }
}