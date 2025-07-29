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

      final tProductModels = [
        ProductModel(
          id: 1,
          title: 'Test',
          subtitle: 'Sub',
          price: 2,
          imageurl: 'url',
          discription: 'desc',
        ),
      ];

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

      final tProductModels = [
        ProductModel(
          id: 1,
          title: 'Test',
          subtitle: 'Sub',
          price: 2,
          imageurl: 'url',
          discription: 'desc',
        ),
      ];

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

      final tProductModels = ProductModel(
        id: 1,
        title: 'Test',
        subtitle: 'Sub',
        price: 2,
        imageurl: 'url',
        discription: 'desc',
      );

      int tid = 1;

      test(
        'should update the data locally when the remote data source is succesfull',
        () async {
          when(
            productRemoteDataSource.updateProduct(tid, tProductModels),
          ).thenAnswer((_) async => tProductModels);

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModels,
          );

          verify(productRemoteDataSource.updateProduct(tid, tProductModels));

          expect(result, equals(Right(tProductModels)));
        },
      );

      test(
        'should return server error when the remote data source is unsuccesfull',
        () async {
          when(
            productRemoteDataSource.updateProduct(tid, tProductModels),
          ).thenThrow(ServerException());

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModels,
          );

          /// this check wather remote source is called or not
          verify(productRemoteDataSource.updateProduct(tid, tProductModels));

          /// this check does it throw server exception or not
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      final tProductModels = ProductModel(
        id: 1,
        title: 'Test',
        subtitle: 'Sub',
        price: 2,
        imageurl: 'url',
        discription: 'desc',
      );

      int tid = 1;

      test('should return local data when the device is offline', () async {
        when(
          productLocalDataSource.updateProduct(tid, tProductModels),
        ).thenAnswer((_) async => tProductModels);

        final result = await productRepositoryImp.updateProduct(
          tid,
          tProductModels,
        );

        verify(productLocalDataSource.updateProduct(tid, tProductModels));

        expect(result, equals(Right(tProductModels)));
      });

      test(
        'should return cache error when the local data source is unsuccesfull',
        () async {
          when(
            productLocalDataSource.updateProduct(tid, tProductModels),
          ).thenThrow(CacheException());

          final result = await productRepositoryImp.updateProduct(
            tid,
            tProductModels,
          );

          /// this check wather remote source is called or not
          verify(productLocalDataSource.updateProduct(tid, tProductModels));

          /// this check does it throw server exception or not
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

    group('getProductById', () {
    final tProductModel = ProductModel(
      id: 1,
      title: 'Test',
      subtitle: 'Sub',
      price: 2,
      imageurl: 'url',
      discription: 'desc',
    );

    const tId = 1;

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return product from remote data source', () async {
        when(productRemoteDataSource.getProductById(tId))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.getProductById(tId);

        verify(productRemoteDataSource.getProductById(tId));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return server failure when remote throws', () async {
        when(productRemoteDataSource.getProductById(tId))
            .thenThrow(ServerException());

        final result = await productRepositoryImp.getProductById(tId);

        verify(productRemoteDataSource.getProductById(tId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return product from local data source', () async {
        when(productLocalDataSource.getProductById(tId))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.getProductById(tId);

        verify(productLocalDataSource.getProductById(tId));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return cache failure when local throws', () async {
        when(productLocalDataSource.getProductById(tId))
            .thenThrow(CacheException());

        final result = await productRepositoryImp.getProductById(tId);

        expect(result, equals(Left(CacheFailure())));
        verify(productLocalDataSource.getProductById(tId));
      });
    });
  });

  group('addProduct', () {
    final tProductModel = ProductModel(
      id: 1,
      title: 'Test',
      subtitle: 'Sub',
      price: 2,
      imageurl: 'url',
      discription: 'desc',
    );

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
    const tId = 1;

    final tProductModel = ProductModel(
      id: 1,
      title: 'Test',
      subtitle: 'Sub',
      price: 2,
      imageurl: 'url',
      discription: 'desc',
    );

    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should delete product remotely', () async {
        when(productRemoteDataSource.deleteProduct(tId))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.deleteProduct(tId);

        verify(productRemoteDataSource.deleteProduct(tId));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return server failure when remote fails', () async {
        when(productRemoteDataSource.deleteProduct(tId))
            .thenThrow(ServerException());

        final result = await productRepositoryImp.deleteProduct(tId);

        verify(productRemoteDataSource.deleteProduct(tId));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should delete product locally', () async {
        when(productLocalDataSource.deleteProduct(tId))
            .thenAnswer((_) async => tProductModel);

        final result = await productRepositoryImp.deleteProduct(tId);

        verify(productLocalDataSource.deleteProduct(tId));
        expect(result, equals(Right(tProductModel)));
      });

      test('should return cache failure when local fails', () async {
        when(productLocalDataSource.deleteProduct(tId))
            .thenThrow(CacheException());

        final result = await productRepositoryImp.deleteProduct(tId);

        verify(productLocalDataSource.deleteProduct(tId));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

}
