import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:search_bar/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loadingScreen.dart';
import '../resetPassword.dart';
import 'package:url_launcher/url_launcher.dart';



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
  String url = 'https://www.nooks-app.com/';

  String email ='';
  String password ='';
  String error ='';
  late Future<List<String>> credentials;
  //late Future<String> lastPassword;

  @override
  void initState(){
    credentials = getCredentials();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
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
              launchURL(url);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: FutureBuilder<List<String>>(
            future: credentials,
            builder: (
                BuildContext context,
                AsyncSnapshot<List<String>> snapshot,
                ) {
              if (snapshot.hasData) {
                return Form(
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
                              initialValue:(error != '' && email != '') ? email : snapshot.data![0],
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
                              initialValue:(error != '' && password != '') ? password : snapshot.data![1],
                              validator: (val) => val!.length < 6 ? 'Entrez un mot de passe' : null,
                              onChanged: (val){
                                setState(() => password = val);
                              }
                          ),
                          SizedBox(height: 10.0),
                          RichText(
                            text: TextSpan(
                                text: 'Mot de passe oublié ? ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      customPageRouteBuilder(ResetPassword()),
                                    );
                                  },
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
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
                                  dynamic result = await _auth.signInWithEmailAndPassword(
                                      (email != '') ? email : snapshot.data![0],
                                      (password != '') ? password : snapshot.data![1]);
                                  if(result == null){
                                    setState(() {
                                      error = 'Adresse mail ou mot de passe incorrect';
                                      loading = false;

                                    } );
                                  }else{
                                    final prefs = await SharedPreferences.getInstance();
                                    if(_checkbox) {
                                      setState(() {
                                        prefs.setString('email', (email != '') ? email : snapshot.data![0]);
                                        prefs.setString('password', (password != '') ? password : snapshot.data![1]);
                                      });
                                      print(prefs.getString('email'));
                                    }
                                    setState(() => prefs.setString('password2', (password != '') ? password : snapshot.data![1]));
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
                );
              }else if (snapshot.hasError) {
                return const Text('Error');
              }else{
                return Container();
              }
            }
        ),
      ),
    );
  }

  Future<List<String>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return [prefs.getString('email') ?? '' ,prefs.getString('password') ?? ''];
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
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
