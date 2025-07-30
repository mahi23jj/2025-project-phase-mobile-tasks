import 'package:dartz/dartz.dart';


import '../../../../core/Error/failure.dart';
import '../Entity/product_entity.dart';
import '../Repository/product_repository.dart';

class ViewSingleProduct {
  final ProductRepository productRepository;
   ViewSingleProduct(this.productRepository);
   
   Future<Either<Failure, Product>> call(int id) async {
    return await productRepository.getProductById(id);
  }
}