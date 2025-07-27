import '../Repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository productRepository;
  DeleteProduct(this.productRepository);

  Future<void> call(int id) async {
    await productRepository.deleteProduct(id);
  }
  
}