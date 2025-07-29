import 'dart:io';

String readJson(String fileName) {
  try {
    final path = 'test/helper/$fileName.json'; // Make sure this is correct
    final contents = File(path).readAsStringSync();
    return contents;
  } catch (e) {
    rethrow;
  }
}
