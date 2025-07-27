import 'package:dartz/dartz.dart';

import '../../../../core/Error/exception.dart';
import '../../../../core/Error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/Entity/product_entity.dart';
import '../../domain/Repository/product_repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

class ProductRepositoryImp extends ProductRepository {
  final ProductLocalDataSource productLocalDataSource;
  final ProductRemoteDataSource productRemoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImp({
    required this.networkInfo,
    required this.productLocalDataSource,
    required this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource.getAllProduct();
        await productLocalDataSource.cacheProduct(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await productLocalDataSource.getlastProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.getProductById(id);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await productLocalDataSource.getProductById(id);
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.addProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await productLocalDataSource.addProduct(product);
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(int id, Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.updateProduct(id, product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await productLocalDataSource.updateProduct(id, product);
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.deleteProduct(id);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await productLocalDataSource.deleteProduct(id);
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
