import 'dart:io';

String readJson(String fileName) {
  return File('C:/Users/solom/flutter project/A2SV/Practice/mobile/Mahlet/product_3/test/helper/$fileName.json').readAsStringSync();
}