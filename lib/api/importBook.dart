import '../model/firebase_file.dart';
import 'firebase_firestor_api.dart';
import 'firebase_storage_api.dart';
import 'package:search_bar/widget/books.dart';

Future<List<Book>> initBooks() async {
  FirebaseFile myEpubFile;
  FirebaseFile myImageFile;
  List<Object?> myDataBaseList;

  List<Book> myData = [];
  myDataBaseList = await FirebaseFirestoreApi.getCollection("Livres");

  for (int i = 0; i < myDataBaseList.length; i++) {
    Map<String, dynamic> a = myDataBaseList[i] as Map<String, dynamic>;

    myEpubFile = await FirebaseStorageApi.listSingle("Epubs", a['epubFile']);
    myImageFile = await FirebaseStorageApi.listSingle("Images", a['imageFile']);

    myData.add(
        Book.map(myDataBaseList[i] as Map, myImageFile.url, myEpubFile.url));
  }

  return myData;
}

Future<List<Book>> initNewParution() async {
  List<Object?> myDataBaseList;
  List<Book> newBooks = [];

  myDataBaseList =
      await FirebaseFirestoreApi.getLastFromCollection("Livres", "Parution", 5);
  for (int i = 0; i < myDataBaseList.length; i++) {
    Map<String, dynamic> a = myDataBaseList[i] as Map<String, dynamic>;
    var myEpubFile =
        await FirebaseStorageApi.listSingle("Epubs", a['epubFile']);
    var myImageFile =
        await FirebaseStorageApi.listSingle("Images", a['imageFile']);
    newBooks.add(
        Book.map(myDataBaseList[i] as Map, myImageFile.url, myEpubFile.url));
  }
  return newBooks;
}
