
import '../../domain/Entity/product_entity.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> addProduct(Product product);
  Future<ProductModel> updateProduct(String id, Product product);
  Future<void> deleteProduct(String id);
}
