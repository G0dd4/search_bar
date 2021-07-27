import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_bar/services/bddUsers.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;



  //auth change user stream
  Stream<User?> get user{
    return _auth.authStateChanges();
  }


  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with email & password
  Future registerWithEmailAndPassword(String email, String password, String lastName, String firstName, String pseudo) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await BddUser(uid: user!.uid).updateUserData(lastName,firstName,email,password,pseudo);
      /*await BddUser(uid: user!.uid).updateEmail(email);
      await BddUser(uid: user.uid).updateLastName(lastName);
      await BddUser(uid: user.uid).updateFirstName(firstName);
      await BddUser(uid: user.uid).updatePassword(password);
      await BddUser(uid: user.uid).updatePseudo(pseudo);*/
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future reAuthenticate(String email,String password) async {
    try{
      User? user = FirebaseAuth.instance.currentUser!;
      UserCredential authResult = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        )
      );
        return authResult.user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

 // getEmail() async{
 //    try{
 //      return _auth.currentUser!.email;
 //    }catch(e){
 //      print(e.toString());
 //      return null;
 //    }
 //  }
}