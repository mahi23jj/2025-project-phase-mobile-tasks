
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProduct();
  Future<ProductModel> getProductById(int id);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(int id, ProductModel product);
  Future<ProductModel> deleteProduct(int id);
}
