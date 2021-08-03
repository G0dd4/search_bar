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
      await BddUser().updateUserData(lastName,firstName,email,pseudo);
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

  Future updateEmail(String email, String password,String newEmail) async {
    try{
      User? user = FirebaseAuth.instance.currentUser!;
      UserCredential authResult = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        )
      );
        User? user2 =  authResult.user;
        user2!.updateEmail(newEmail);
        return user2;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future updatePassword(String email, String password,String newPassword) async {
    try{
      User? user = FirebaseAuth.instance.currentUser!;
      UserCredential authResult = await user.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: email,
            password: password,
          )
      );
      User? user2 =  authResult.user;
      user2!.updatePassword(newPassword);
      return user2;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
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