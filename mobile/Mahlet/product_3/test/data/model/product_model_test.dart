import 'dart:io';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:product_3/features/product/data/model/product_model.dart';
import 'package:product_3/features/product/domain/Entity/product_entity.dart';

import '../../helper/read_json.dart';

void main() {
  final productModel = ProductModel(
    id: 'a1',
    discription: 'jfjw',
    imageurl: 'wah',
    title: 'wjeq',
    price: 12.0,
  );
  
  test('Product Model should be a subclass of ProductEntity', () async {
    // Arrange
    expect(productModel, isA<Product>());
  });



  test('should return a valid ProductModel from json', () async {
    final productjson = json.decode(readJson('dummy'));
    // Arrange
    final products = ProductModel.fromJson(productjson);
    // Act
    expect(products, equals(productModel));
  });



  test('should return a json map containing the proper data', () async {
    // Arrange
    final productjson = json.decode(readJson('dummy'));

    final expectedMap = productModel.toJson();

    // Act
    expect(productjson, equals(expectedMap));
  });
}
