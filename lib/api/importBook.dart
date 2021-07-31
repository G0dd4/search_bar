import '../model/firebase_file.dart';
import 'firebase_firestor_api.dart';
import 'firebase_storage_api.dart';
import 'package:search_bar/widget/books.dart';

List<Book> initialBooks = [];
List<Book> filteredBooks = [];
List<Book> preFilteredBooks = [];
List<Book> newParutionBooks = [];

List<FirebaseFile> myEpubFileList = [];
List<FirebaseFile> myImageFileList = [];

Future<void> initLink() async {
  myEpubFileList = await FirebaseStorageApi.listAll("Epubs/");
  myImageFileList = await FirebaseStorageApi.listAll("Images/");
  await initBooks();
}

Future<void> initBooks() async {
  List<Object?> myDataBaseList;

  myDataBaseList = await FirebaseFirestoreApi.getCollection("Livres");

  for (int index = 0; index < myEpubFileList.length; index++) {
    bool stateEpub = false;
    bool stateImage = false;
    for (int j = index; j < myDataBaseList.length; j++) {
      var a = myDataBaseList[j] as Map<String, dynamic>;
      if (myEpubFileList[index].name.contains(a['epubFile'])) {
        Object? tmp = myDataBaseList[index];
        myDataBaseList[index] = myDataBaseList[j];
        myDataBaseList[j] = tmp;
        stateEpub = true;
      }
      if (myEpubFileList[index].name.contains(a['imageFile'])) {
        var tmp = myImageFileList[index];
        myImageFileList[index] = myImageFileList[j];
        myImageFileList[j] = tmp;
        stateImage = true;
      }
      if (stateImage == true && stateEpub == true) break;
    }
  }

  for (int i = 0; i < myEpubFileList.length; i++) {
    initialBooks.add(Book.map(myDataBaseList[i] as Map, myImageFileList[i].url,
        myEpubFileList[i].url));
  }
  preFilteredBooks = initialBooks;
  filteredBooks = initialBooks;
}

Future<List<Book>> initNewParution() async {
  List<Object?> myDataBaseList;
  List<Book> newBooks = [];
  myDataBaseList =
      await FirebaseFirestoreApi.getLastFromCollection("Livres", "Parution", 5);
  for (int i = 0; i < myDataBaseList.length; i++) {
    newBooks.add(Book.map(myDataBaseList[i] as Map, myImageFileList[i].url,
        myEpubFileList[i].url));
  }
  return newBooks;
}
