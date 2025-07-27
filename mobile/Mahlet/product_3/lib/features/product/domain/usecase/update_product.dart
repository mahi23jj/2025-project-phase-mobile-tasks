import '../Entity/product_entity.dart';
import '../Repository/product_repository.dart';

class UpdateProduct {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  Future<void> call(int id,Product product) async {
    await productRepository.updateProduct(id,product);
  }
}