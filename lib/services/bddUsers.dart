import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_bar/models/userData.dart';
import 'package:search_bar/widget/books.dart';

class BddUser{

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  BddUser();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usersCollection = FirebaseFirestore.instance.collection('Utilisateurs');
  CollectionReference booksCollection = FirebaseFirestore.instance.collection('Livres');

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

  Future addBooks(String title,String author,String imageUrl,String genre,String id) async {
    return await usersCollection.doc(uid).collection('Ma bibliothèque').doc(id).set({
      'Titre': title,
      'Auteur': author,
      'Couverture': imageUrl,
      'Genre': genre,
      'id': id,
      'isadded': true
    });
  }

  Future deleteBooks(String id) async{
    return await usersCollection.doc(uid).collection('Ma bibliothèque').doc(id).delete();
  }

  Future checkExit(String id) async{
    return await usersCollection.doc(uid).collection('Ma bibliothèque').doc(id).get().then((doc)
    =>  doc.exists);
  }

  Future compare(String titre,String auteur) async {
    var ref = (usersCollection.doc(uid).collection('Ma bibliothèque').where(
        'Auteur', isEqualTo: auteur)).where('Titre', isEqualTo: titre);
    var data = await ref.get();

    return data.docs.map((doc) =>doc.data()).toList();
  }

 List<Book> _listBooksToLibraryFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Book(
        doc.get('Auteur'),
        doc.get('Titre'),
        doc.get('Couverture'),
        doc.get('Genre'),
        doc.get('id')
      );
    }).toList();
  }

  Stream<List<Book>> get booksToLibrary {
    return usersCollection.doc(uid).collection('Ma bibliothèque').snapshots().map(_listBooksToLibraryFromSnapshot);
  }

  List<Book> _listBooksFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Book(
          doc.get('Author'),
          doc.get('Title'),
          doc.get('imageFile'),
          '',
          doc.id,
      );
    }).toList();
  }

  Stream<List<Book>> get books{
    return booksCollection.snapshots().map(_listBooksFromSnapshot);
  }

}

