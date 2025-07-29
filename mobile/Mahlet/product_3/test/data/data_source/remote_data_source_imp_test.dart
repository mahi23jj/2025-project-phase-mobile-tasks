import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as Http;
import 'package:mockito/mockito.dart';
import 'package:product_3/core/Error/exception.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source_imp.dart';
import 'package:product_3/features/product/data/model/product_model.dart';

import '../../helper/read_json.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late Http.Client httpclient;
  late RemoteDataSourceImp remoteDataSourceImp;

  setUp(() {
    httpclient = MockHttpClient();
    remoteDataSourceImp = RemoteDataSourceImp(client: httpclient);
  });

  group('getAllProducts', () {
    final tjsondata = jsonDecode(readJson('dummy')) as List;
    final tListProduct = tjsondata
        .map((e) => ProductModel.fromJson(e))
        .toList();

    test(
      'should return list of product from remote data source succesfuly',
      () async {
        when(
          httpclient.get(
            Uri.parse('https://fakestoreapi.com/products'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response(readJson('dummy'), 200));

        final result = await remoteDataSourceImp.getAllProduct();

        expect(result, equals(tListProduct));
      },
    );

    test(
      'should throw exception for unsuccesfuly list of product from remote data source',
      () async {
        when(
          httpclient.get(
            Uri.parse('https://fakestoreapi.com/products'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response('error', 404));

        final call = remoteDataSourceImp.getAllProduct;

        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getProductbyid', () {
    int id = 1;
    final item = ProductModel(
      id: 1,
      imageurl: 'https://example.com/image.png',
      title: 'Test Product',
      subtitle: 'Test Subtitle',
      price: 100,
      discription: 'This is a test product',
    );

    // to json
    final tjsondata = item.toJson();

    test(
      'should return a product from remote data source succesfuly',
      () async {
        when(
          httpclient.get(
            Uri.parse('https://fakestoreapi.com/products/$id'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response(jsonEncode(tjsondata), 200));

        final result = await remoteDataSourceImp.getProductById(id);

        expect(result, equals(item));
      },
    );

    test(
      'should throw exception for unsuccesfuly a product from remote data source',
      () async {
        when(
          httpclient.get(
            Uri.parse('https://fakestoreapi.com/products/$id'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response('error', 404));

        final call = remoteDataSourceImp.getProductById;

        expect(() => call(id), throwsA(isA<ServerException>()));
      },
    );
  });

    group('addproduct', () {

    final item = ProductModel(
      id: 1,
      imageurl: 'https://example.com/image.png',
      title: 'Test Product',
      subtitle: 'Test Subtitle',
      price: 100,
      discription: 'This is a test product',
    );

    // to json
    final tjsondata = jsonEncode(item.toJson());

    test(
      'should add a product  to list in from remote data source succesfuly',
      () async {
        when(
          httpclient.post(
            Uri.parse('https://fakestoreapi.com/products'),
            body: tjsondata,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response(tjsondata, 201));

        final result = await remoteDataSourceImp.addProduct(item);

        expect(result, equals(item));
      },
    );


   test(
      'should throw exception for unsuccesfuly a product from remote data source',
      () async {
        when(
           httpclient.post(
            Uri.parse('https://fakestoreapi.com/products'),
            body: tjsondata,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => Http.Response('error', 404));

        final call = remoteDataSourceImp.addProduct;

        expect(() => call(item), throwsA(isA<ServerException>()));
      },
  );
    // test(
    //   'should throw exception for unsuccesfuly a product from remote data source',
    //   () async {
    //     when(
    //       httpclient.get(
    //         Uri.parse('https://fakestoreapi.com/products/$id'),
    //         headers: anyNamed('headers'),
    //       ),
    //     ).thenAnswer((_) async => Http.Response('error', 404));

    //     final call = remoteDataSourceImp.getProductById;

    //     expect(() => call(id), throwsA(isA<ServerException>()));
    //   },
    // );
  });
group('updateProduct', () {
  final id = 1;

  final item = ProductModel(
    id: 1,
    imageurl: 'https://example.com/image.png',
    title: 'Updated Product',
    subtitle: 'Updated Subtitle',
    price: 200,
    discription: 'This is an updated product',
  );

  final tjsondata = jsonEncode(item.toJson());

  test(
    'should update a product successfully via remote data source',
    () async {
      when(
        httpclient.put(
          Uri.parse('https://fakestoreapi.com/products/$id'),
          body: tjsondata,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => Http.Response(tjsondata, 200));

      final result = await remoteDataSourceImp.updateProduct(id, item);

      expect(result, equals(item));
    },
  );

  test(
    'should throw exception when update fails',
    () async {
      when(
        httpclient.put(
          Uri.parse('https://fakestoreapi.com/products/$id'),
          body: tjsondata,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => Http.Response('error', 404));

      final call = remoteDataSourceImp.updateProduct;

      expect(() => call(id, item), throwsA(isA<ServerException>()));
    },
  );
});

group('deleteProduct', () {
  final id = 1;

  test(
    'should delete a product successfully from remote data source',
    () async {
      when(
        httpclient.delete(
          Uri.parse('https://fakestoreapi.com/products/$id'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => Http.Response('{}', 200));

    await remoteDataSourceImp.deleteProduct(id);

      expect(remoteDataSourceImp.deleteProduct(id), completes);
    },
  );

  test(
    'should throw exception when delete fails',
    () async {
      when(
        httpclient.delete(
          Uri.parse('https://fakestoreapi.com/products/$id'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => Http.Response('error', 404));

      final call = remoteDataSourceImp.deleteProduct;

      expect(() => call(id), throwsA(isA<ServerException>()));
    },
  );
});

  
}
