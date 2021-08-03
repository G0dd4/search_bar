import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _checkbox = true;

  String email ='';
  String password ='';
  String lastName='';
  String firstName='';
  String pseudo='';
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
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height:20.0),
                  TextFormField(
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
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password,lastName,firstName,pseudo);
                          if(result == null){
                            setState(() => error = 'Entrez une adresse mail et un mot de passe valides');
                          }else{
                            if(_checkbox) {
                              final prefs = await SharedPreferences.getInstance();
                              setState(() {
                                prefs.setString('email', email);
                                prefs.setString('password', password);
                              });
                            }
                          }
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Enregistrer les identifiants de connexion'),
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
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
