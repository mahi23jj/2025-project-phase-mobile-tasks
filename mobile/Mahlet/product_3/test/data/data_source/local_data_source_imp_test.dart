import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_3/core/Error/exception.dart';
import 'package:product_3/features/product/data/data_source/local_data_source_imp.dart';
import 'package:product_3/features/product/data/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/read_json.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late LocalDataSourceImp localDataSourceImp;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSourceImp = LocalDataSourceImp(sharedPreferences);
  });

String id = 'a1';
   final value = [
      ProductModel(
        id: 'a1',
        imageurl: 'https://example.com/image.png',
        title: 'Test Product',
        price: 100,
        discription: 'This is a test product',
      ),
    ];

  group('getlastproduct', () {
    final dummy_product_json = jsonDecode(readJson('dummy')) as List;
    final dummy_product = dummy_product_json
        .map((e) => ProductModel.fromJson(e))
        .toList();

    test('should return last product from shared preferences', () async {
      //arrange
      when(
        sharedPreferences.getString('Cached_products'),
      ).thenReturn(readJson('dummy'));

      //act
      final result = await localDataSourceImp.getlastProducts();

      //assert
      verify(sharedPreferences.getString('Cached_products'));
      expect(result, equals(dummy_product));
    });

    test('should throw error for unsuccesfull fache from local data', () async {
      //arrange
      when(sharedPreferences.getString('Cached_products')).thenReturn(null);

      //act
      final result = localDataSourceImp.getlastProducts;

      //assert
      expect(() => result(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheProduct', () {
   

    test('should cache last product to shared preferences', () async {
      //act

      final expectedjson = jsonEncode(value.map((e) => e.toJson()).toList());

      when(
        sharedPreferences.setString('Cached_products_list', expectedjson),
      ).thenAnswer((_) async => true); // or `=> Future.value(true);`

      await localDataSourceImp.cacheProduct(value);
      //assert
      verify(sharedPreferences.setString('Cached_products_list', expectedjson));
    });
  });

  group('getProductById', () {
    final item = ProductModel(
      id: 'a1',
      imageurl: 'https://example.com/image.png',
      title: 'Test Product',
      price: 100,
      discription: 'This is a test product',
    );
    final dummy_product_json = jsonDecode(readJson('dummy')) as List;
    final dummy_product = dummy_product_json
        .map((e) => ProductModel.fromJson(e))
        .toList();
    test(
      'should return from last product by id to shared preferences',
      () async {
        //act
        when(
          sharedPreferences.getString('Cached_products'),
        ).thenReturn(readJson('dummy'));

        final actual = await localDataSourceImp.getProductById(id);

        //assert
        expect(actual, equals(item));
      },
    );

    test(
      'should throw error for unsuccesfull fache from local data by id',
      () async {
        //arrange

        when(sharedPreferences.getString('Cached_products')).thenReturn(null);

        //       //act
        final result = localDataSourceImp.getProductById;

        //       //assert
        expect(() => result(id), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('addProduct', () {
  final newProduct = ProductModel(
    id: 'a3',
    imageurl: 'https://example.com/image3.png',
    title: 'New Product',
  
    price: 150,
    discription: 'This is a new product',
  );

  final existingProducts = [
    ProductModel(
      id: 'a1',
      imageurl: 'https://example.com/image.png',
      title: 'Test Product',
     
      price: 100,
      discription: 'This is a test product',
    ),
  ];

  test('should add a product and update cache', () async {
    // Arrange
    when(sharedPreferences.getString('Cached_products'))
        .thenReturn(jsonEncode(existingProducts.map((e) => e.toJson()).toList()));

    final updatedList = [...existingProducts, newProduct];

    when(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(updatedList.map((e) => e.toJson()).toList()),
    )).thenAnswer((_) async => true);

    // Act
    final result = await localDataSourceImp.addProduct(newProduct);

    // Assert
    expect(result, equals(newProduct));
    verify(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(updatedList.map((e) => e.toJson()).toList()),
    ));
  });
});

group('deleteProduct', () {
  final initialList = [
    ProductModel(
      id: 'a1',
      imageurl: 'https://example.com/image.png',
      title: 'Product A',
   
      price: 100,
      discription: 'Product A desc',
    ),
    ProductModel(
      id: 'a2',
      imageurl: 'https://example.com/image2.png',
      title: 'Product B',
      
      price: 150,
      discription: 'Product B desc',
    ),
  ];

  test('should delete a product by id and update cache', () async {
    // Arrange
    when(sharedPreferences.getString('Cached_products'))
        .thenReturn(jsonEncode(initialList.map((e) => e.toJson()).toList()));

    final expectedList = initialList.where((e) => e.id != 1).toList();

    when(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(expectedList.map((e) => e.toJson()).toList()),
    )).thenAnswer((_) async => true);

    // Act
    await localDataSourceImp.deleteProduct(id);

    // Assert
    verify(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(expectedList.map((e) => e.toJson()).toList()),
    ));
  });
});

group('updateProduct', () {
  final updatedProduct = ProductModel(
    id: 'a1',
    imageurl: 'https://example.com/image_updated.png',
    title: 'Updated Product',
   
    price: 200,
    discription: 'This is an updated product',
  );

  final initialList = [
    ProductModel(
      id: 'a1',
      imageurl: 'https://example.com/image.png',
      title: 'Old Product',
      price: 100,
      discription: 'Old product desc',
    ),
  ];

  test('should update existing product and update cache', () async {
    // Arrange
    when(sharedPreferences.getString('Cached_products'))
        .thenReturn(jsonEncode(initialList.map((e) => e.toJson()).toList()));

    final expectedList = [updatedProduct];
    when(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(expectedList.map((e) => e.toJson()).toList()),
    )).thenAnswer((_) async => true);

    // Act
    final result = await localDataSourceImp.updateProduct(id, updatedProduct);

    // Assert
    expect(result, equals(updatedProduct));
    verify(sharedPreferences.setString(
      'Cached_products',
      jsonEncode(expectedList.map((e) => e.toJson()).toList()),
    ));
  });
});

}
