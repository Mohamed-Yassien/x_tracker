import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> localFile() async {
    final path = await localPath();
    return File('$path/image.txt');
  }

  static Future<File> writeToFile(String data) async {
    final file = await localFile();
    return file.writeAsString(data);
  }

  static Future<String> readFromFiles() async {
    final file = await localFile();
    return file.readAsString();
  }
}
