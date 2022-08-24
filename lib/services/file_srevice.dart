import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile() async {
    final path = await localPath();
    return File('$path/location.txt');
  }

  Future<File> writeToFile(String data) async {
    final file = await localFile();
    return file.writeAsString(data);
  }

  Future<String> readFromFiles() async {
    final file = await localFile();
    return file.readAsString();
  }
}
