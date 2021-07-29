import 'dart:io';
import 'package:epubx/epubx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class EpubApi {
  static Future<EpubBook> getEpubBookFile(String file) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetFile = new File('${appDocDir.path}/$file');

    List<int> bytes = await targetFile.readAsBytes();
    return await EpubReader.readBook(bytes);
  }

  static Future<EpubBook> getEpubBookStreaming(String uri) async {
    var url = Uri.parse(uri);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return await EpubReader.readBook(response.bodyBytes);
    } else
      throw Exception('Imposible de streamer');
  }
}
