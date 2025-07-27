import 'package:dartz/dartz.dart';


import '../../../../core/Error/failure.dart';
import '../Entity/product_entity.dart';
import '../Repository/product_repository.dart';

class CreateProduct {

  final ProductRepository productRepository;
  CreateProduct(this.productRepository);

   Future<Either<Failure, Product>> call(Product product) async {
    return await productRepository.addProduct(product);
  }
  
}