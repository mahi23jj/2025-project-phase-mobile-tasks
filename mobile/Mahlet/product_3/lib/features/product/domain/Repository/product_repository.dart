import 'package:dartz/dartz.dart';

import '../../../../core/Error/error.dart';
import '../Entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(int id,Product product);
  Future<Either<Failure, Product>> deleteProduct(int id);

}
