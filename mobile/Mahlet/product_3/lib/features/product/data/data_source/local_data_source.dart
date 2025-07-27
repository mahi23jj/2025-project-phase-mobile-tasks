import '../../domain/Entity/product_entity.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getlastProducts();
  Future<void> cacheProduct(List<Product> products);
}