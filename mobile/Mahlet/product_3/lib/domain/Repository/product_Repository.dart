

import 'package:dartz/dartz.dart';
import 'package:product_3/domain/Entity/product_Entity.dart';

import '../../core/Error/error.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(int id,Product product);
  Future<Either<Failure, Product>> deleteProduct(int id);

}
