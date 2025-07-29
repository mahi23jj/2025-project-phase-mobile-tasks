
import '../../domain/Entity/product_entity.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct();
  Future<ProductModel> getProductById(int id);
  Future<ProductModel> addProduct(Product product);
  Future<ProductModel> updateProduct(int id, Product product);
  Future<void> deleteProduct(int id);
}
