import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_bar/models/userData.dart';

class BddUser{

  final String uid;
  BddUser({required this.uid});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usersCollection = FirebaseFirestore.instance.collection('Utilisateurs');

  /*Future updateLastName(String lastName) async{
    return await usersCollection.doc(uid).set({'Nom' : lastName});
  }

  Future updateFirstName(String firstName) async{
    return await usersCollection.doc(uid).set({'Prénom' : firstName});
  }

  Future updateEmail(String email) async{
    return await usersCollection.doc(uid).set({'Email' : email});
  }

  Future updatePassword(String password) async{
    return await usersCollection.doc(uid).set({'Mot de passe' : password});
  }

  Future updatePseudo(String pseudo) async{
    return await usersCollection.doc(uid).set({'Pseudo' : pseudo});
  }*/

  Future updateUserData(String lastName,String firstName,String email,String password,String pseudo) async{
    return await usersCollection.doc(uid).set({
      'Nom' : lastName,
      'Prénom' : firstName,
      'Email' : email,
      'Mot de passe' : password,
      'Pseudo' : pseudo
    });
  }

 /* List<UserData> _listUserDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return UserData(
          lastName: doc['lastName'] ?? '',
          firstName: doc['firstName'] ?? '',
          email: doc['email'] ?? '',
          password: doc['password'] ?? '',
          pseudo: doc['pseudo'] ?? '',
      );
    }).toList();
  }

  Stream<List<UserData>> get users {
    return usersCollection.snapshots().map(_listUserDataFromSnapshot);
  }*/

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(lastName: snapshot.get('Nom'),
        firstName: snapshot.get('Prénom'),
        email: snapshot.get('Email'),
        password: snapshot.get('Mot de passe'),
        pseudo: snapshot.get('Pseudo'),
        uid: uid);
  }

  Stream<UserData> get userData{
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

