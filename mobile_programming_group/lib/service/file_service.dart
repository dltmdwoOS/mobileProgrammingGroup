import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

Future<int> countFiles(String path) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final dirPath = "${directory.path}/$path";
    final dir = Directory(dirPath);

    if (await dir.exists() && await dir.stat().then((value) => value.type == FileSystemEntityType.directory)) {
      List<FileSystemEntity> files = dir.listSync();
      int fileCount = files.whereType<File>().length;
      return fileCount;
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

Future<void> saveJsonToFile(Map<String, dynamic> jsonData, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = "${directory.path}/$fileName";
  final file = File(filePath);

  if (!await file.parent.exists()) {
    await file.parent.create(recursive: true);
  }

  await file.writeAsString(jsonEncode(jsonData), flush: true);
}

Future<Map<String, dynamic>?> readJsonFromFile(String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName";
    final file = File(filePath);

    if (!await file.exists()) {
      return null;
    }

    final contents = await file.readAsString();
    return jsonDecode(contents) as Map<String, dynamic>;
  } catch (e) {
    return null;
  }
}
