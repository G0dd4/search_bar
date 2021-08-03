import 'dart:io';
import 'package:search_bar/model/firebase_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future<FirebaseFile> listSingle(String path, String file) async {
    final ref = FirebaseStorage.instance.ref().child(path).child(file);

    final url = await ref.getDownloadURL();
    final dataToReturn = FirebaseFile(ref: ref, name: ref.name, url: url);

    return dataToReturn;
  }

  static Future downloadFile(Reference ref) async {
    //final dir = await getApplicationDocumentsDirectory();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    print('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}
