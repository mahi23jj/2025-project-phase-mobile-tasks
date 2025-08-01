import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_3/core/Error/exception.dart';
import 'package:product_3/core/Error/failure.dart';
import 'package:product_3/core/platform/network_info.dart';
import 'package:product_3/features/product/data/data_source/local_data_source.dart';
import 'package:product_3/features/product/data/data_source/remote_data_source.dart';
import 'package:product_3/features/product/data/model/product_model.dart';
import 'package:product_3/features/product/data/repository/product_repository_imp.dart';
import 'package:product_3/features/product/domain/Entity/product_Entity.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late ProductRemoteDataSource productRemoteDataSource;
  late ProductLocalDataSource productLocalDataSource;
  late NetworkInfo networkInfo;
  late ProductRepositoryImp productRepositoryImp;

  setUp(() {
    productLocalDataSource = MockProductLocalDataSource();
    networkInfo = MockNetworkInfo();
    productRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImp = ProductRepositoryImp(
      networkInfo: networkInfo,
      productRemoteDataSource: productRemoteDataSource,
      productLocalDataSource: productLocalDataSource,
    );
  });



  final tProductModels = [
        ProductModel(
          id: 'a1',
          title: 'Test',
          price: 2,
          imageurl: 'url',
          discription: 'desc',
        ),
      ];

            final tProductModel = ProductModel(
        id: 'a1',
        title: 'Test',
      
        price: 2,
        imageurl: 'url',
        discription: 'desc',
      );

      String tid = 'a1';
  group('getAllProduct', () {
    test('to check the Network status ', () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await productRepositoryImp.getAllProduct();
      //  varify(networkInfo.isConnected);
      verify(networkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

    

      test(
        'should return the data locally when the remote data source is succesfull',
        () async {
          when(
            productRemoteDataSource.getAllProduct(),
          ).thenAnswer((_) async => tProductModels);

          final result = await productRepositoryImp.getAllProduct();

          verify(productRemoteDataSource.getAllProduct());

          expect(result, equals(Right(tProductModels)));
        },
      );

      test(
        'should cache the data locally when the remote data source is succesfull',
        () async {
          when(
            productRemoteDataSource.getAllProduct(),
          ).thenAnswer((_) async => tProductModels);

          when(
            productLocalDataSource.cacheProduct(tProductModels),
          ).thenAnswer((_) async => {});

          await productRepositoryImp.getAllProduct();

          /// this check wather the data is cached or not from remote source
          verify(productLocalDataSource.cacheProduct(tProductModels));
        },
      );

      test(
        'should return server error when the remote data source is unsuccesfull',
        () async {
          when(
            productRemoteDataSource.getAllProduct(),
          ).thenThrow(ServerException());

          final result = await productRepositoryImp.getAllProduct();

          /// this check wather remote source is called or not
          verify(productRemoteDataSource.getAllProduct());

          /// this check does it throw server exception or not
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });


      test('should return local data when the device is offline', () async {
        when(
          productLocalDataSource.getlastProducts(),
        ).thenAnswer((_) async => tProductModels);

        final result = await productRepositoryImp.getAllProduct();

        verify(productLocalDataSource.getlastProducts());

        expect(result, equals(Right(tProductModels)));
      });

      test(
        'should return cache error when the local data source is unsuccesfull',
        () async {
          when(
            productLocalDataSource.getlastProducts(),
          ).thenThrow(CacheException());

          final result = await productRepositoryImp.getAllProduct();

          /// this check wather remote source is called or not
          verify(productLocalDataSource.getlastProducts());

          /// this check does it throw server exception or not
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('updateProduct', () {
    test('to check the Network status ', () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await productRepositoryImp.getAllProduct();
      //  varify(networkInfo.isConnected);
      verify(networkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });



      test(
        'should update the data locally when the remote data source is succesfull',
        () async {
          when(
            productRemoteDataSource.updateProduct(tid, tProductModel),
          ).thenAnswer((_) async => tProductModel);

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModel,
          );

          verify(productRemoteDataSource.updateProduct(tid, tProductModel));

          expect(result, equals(Right(tProductModel)));
        },
      );

      test(
        'should return server error when the remote data source is unsuccesfull',
        () async {
          when(
            productRemoteDataSource.updateProduct(tid, tProductModel),
          ).thenThrow(ServerException());

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModel,
          );

          /// this check wather remote source is called or not
          verify(productRemoteDataSource.updateProduct(tid, tProductModel));

          /// this check does it throw server exception or not
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });



      test('should return local data when the device is offline', () async {
        when(
          productLocalDataSource.updateProduct(tid, tProductModel),
        ).thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.updateProduct(
          tid,
          tProductModel,
        );

        verify(productLocalDataSource.updateProduct(tid, tProductModel));

        expect(result, equals(Right(tProductModel)));
      });

      test(
        'should return cache error when the local data source is unsuccesfull',
        () async {
          when(
            productLocalDataSource.updateProduct(tid, tProductModel),
          ).thenThrow(CacheException());

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModel,
          );

          /// this check wather remote source is called or not
          verify(productLocalDataSource.updateProduct(tid, tProductModel));

          /// this check does it throw server exception or not
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

    group('getProductById', () {


    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return product from remote data source', () async {
        when(productRemoteDataSource.getProductById(tid))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.getProductById(tid);

        verify(productRemoteDataSource.getProductById(tid));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return server failure when remote throws', () async {
        when(productRemoteDataSource.getProductById(tid))
            .thenThrow(ServerException());

        final result = await productRepositoryImp.getProductById(tid);

        verify(productRemoteDataSource.getProductById(tid));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return product from local data source', () async {
        when(productLocalDataSource.getProductById(tid))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.getProductById(tid);

        verify(productLocalDataSource.getProductById(tid));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return cache failure when local throws', () async {
        when(productLocalDataSource.getProductById(tid))
            .thenThrow(CacheException());

        final result = await productRepositoryImp.getProductById(tid);

        expect(result, equals(Left(CacheFailure())));
        verify(productLocalDataSource.getProductById(tid));
      });
    });
  });

  group('addProduct', () {

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should add product remotely', () async {
        when(productRemoteDataSource.addProduct(tProductModel))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.addProduct(tProductModel);

        verify(productRemoteDataSource.addProduct(tProductModel));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return server failure when remote fails', () async {
        when(productRemoteDataSource.addProduct(tProductModel))
            .thenThrow(ServerException());

        final result = await productRepositoryImp.addProduct(tProductModel);

        verify(productRemoteDataSource.addProduct(tProductModel));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should add product locally', () async {
        when(productLocalDataSource.addProduct(tProductModel))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.addProduct(tProductModel);

        verify(productLocalDataSource.addProduct(tProductModel));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return cache failure when local fails', () async {
        when(productLocalDataSource.addProduct(tProductModel))
            .thenThrow(CacheException());

        final result = await productRepositoryImp.addProduct(tProductModel);

        verify(productLocalDataSource.addProduct(tProductModel));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('deleteProduct', () {

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should delete product remotely', () async {
        when(productRemoteDataSource.deleteProduct(tid))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.deleteProduct(tid);

        verify(productRemoteDataSource.deleteProduct(tid));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return server failure when remote fails', () async {
        when(productRemoteDataSource.deleteProduct(tid))
            .thenThrow(ServerException());

        final result = await productRepositoryImp.deleteProduct(tid);

        verify(productRemoteDataSource.deleteProduct(tid));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should delete product locally', () async {
        when(productLocalDataSource.deleteProduct(tid))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.deleteProduct(tid);

        verify(productLocalDataSource.deleteProduct(tid));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return cache failure when local fails', () async {
        when(productLocalDataSource.deleteProduct(tid))
            .thenThrow(CacheException());

        final result = await productRepositoryImp.deleteProduct(tid);

        verify(productLocalDataSource.deleteProduct(tid));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

}
