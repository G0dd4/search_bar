import '../model/firebase_file.dart';
import 'firebase_firestor_api.dart';
import 'firebase_storage_api.dart';
import 'package:search_bar/widget/books.dart';

List<Book> initialBooks = [];
List<Book> filteredBooks = [];
List<Book> preFilteredBooks = [];
List<Book> newParutionBooks = [];

Future<void> initBooks() async {
  List<FirebaseFile> myEpubFileList;
  List<FirebaseFile> myImageFileList;
  List<Object?> myDataBaseList;

  myEpubFileList = await FirebaseStorageApi.listAll("Epubs/");
  myImageFileList = await FirebaseStorageApi.listAll("Images/");
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
  initNewParution();
}

void initNewParution() {
  var tempData = initialBooks;
  for (int i = 0; i < tempData.length; i++) {
    for (int j = i; j < tempData.length; j++) {
      if (tempData[i].time.isBefore(tempData[j].time)) {
        var bookTmp = tempData[j];
        tempData[j] = tempData[i];
        tempData[i] = bookTmp;
      }
    }
  }
  newParutionBooks = tempData.getRange(0, 7).toList();
}
