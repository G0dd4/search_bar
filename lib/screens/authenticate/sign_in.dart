import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loadingScreen.dart';



class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});
  //const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _checkbox = true;

  String email ='';
  String password ='';
  String error ='';
  late String lastEmail;
  late String lastPassword;


  @override
  Widget build(BuildContext context) {
    lastEmail = getEmail().toString();
    lastPassword = getPassword().toString();
    return loading ? LoadingScreen() : Scaffold(
      backgroundColor: /*Colors.brown[100]*/Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFFCFCFC),
        elevation: 0.0,
        title: Text('Connexion',
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
            label: Text('Inscription',
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
                        //hintText: 'Adresse mail',
                        labelText: 'Adresse mail',
                      ),
                      initialValue: lastEmail,
                      validator: (val) => val!.isEmpty ? 'Entrez une adresse mail' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                      decoration: const InputDecoration(
                        //hintText: 'Mot de passe',
                        labelText: 'Mot de passe',
                      ),
                    obscureText: true,
                      initialValue: lastPassword,
                      validator: (val) => val!.isEmpty ? 'Entrez un mot de passe' : null,
                      onChanged: (val){
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height:20.0),
                  TextButton(
                    child: Text('Connexion',
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
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email,password);
                        if(result == null){
                          setState(() {
                            error = 'Adresse mail ou mot de passe incorrect';
                          loading = false;

                          } );
                      }else{
                          if(_checkbox) {
                            final prefs = await SharedPreferences.getInstance();
                            setState(() {
                              prefs.setString('email', email);
                              prefs.setString('password', password);
                            });
                            print(prefs.getString('email'));
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
                  SizedBox(height: 12.0),
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

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
    }

  Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? '';
  }

  }

