import 'package:dartz/dartz.dart';

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
  Future<Either<Failure, List<Product>>> getAllProduct() {
    // TODO: implement getAllProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(int id, Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
}
