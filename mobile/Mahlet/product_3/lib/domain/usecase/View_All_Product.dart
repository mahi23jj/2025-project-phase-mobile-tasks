import 'package:dartz/dartz.dart';

import '../../core/Error/error.dart';
import '../Entity/product_Entity.dart';
import '../Repository/product_Repository.dart';

class ViewAllProduct {
  final ProductRepository productRepository;
  ViewAllProduct(this.productRepository);
   Future<Either<Failure, List<Product>>> call() async {
    return await productRepository.getAllProduct();
  }
}