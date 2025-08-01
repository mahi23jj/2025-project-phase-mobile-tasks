import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Entity/product_entity.dart';
import '../Repository/product_repository.dart';

class UpdateProduct {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  Future<Either<Failure,Product >> call(String id,Product product) async {
  return await productRepository.updateProduct(id,product);
  }
}