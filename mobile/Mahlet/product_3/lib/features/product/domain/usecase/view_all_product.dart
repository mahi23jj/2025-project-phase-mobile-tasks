import 'package:dartz/dartz.dart';


import '../../../../core/Error/failure.dart';
import '../Entity/product_entity.dart';
import '../Repository/product_repository.dart';

class ViewAllProduct {
  final ProductRepository productRepository;
  ViewAllProduct(this.productRepository);
   Future<Either<Failure, List<Product>>> call() async {
    return await productRepository.getAllProduct();
  }
}