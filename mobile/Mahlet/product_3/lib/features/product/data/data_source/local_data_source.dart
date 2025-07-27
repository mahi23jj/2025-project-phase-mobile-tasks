import '../../domain/Entity/product_entity.dart';
import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getlastProducts();
  Future<void> cacheProduct(List<ProductModel> products);
  Future<ProductModel> getProductById(int id);
  Future<ProductModel> addProduct(Product product);
  Future<ProductModel> updateProduct(int id, Product product);
  Future<ProductModel> deleteProduct(int id);
}
