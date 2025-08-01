import 'package:dartz/dartz.dart';


import '../../../../core/Error/failure.dart';
import '../Entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(String id,Product product);
  Future<Either<Failure, void>> deleteProduct(String id);

}
