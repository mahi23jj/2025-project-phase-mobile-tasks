import 'package:dartz/dartz.dart';

import '../../../../core/Error/failure.dart';
import '../Repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository productRepository;
  DeleteProduct(this.productRepository);

  Future<Either<Failure, void>> call(String id) async {
   return await productRepository.deleteProduct(id);
  }
  
}