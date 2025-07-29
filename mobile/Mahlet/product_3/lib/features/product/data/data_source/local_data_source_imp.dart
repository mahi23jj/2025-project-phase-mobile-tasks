import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Error/exception.dart';
import '../../domain/Entity/product_entity.dart';
import '../model/product_model.dart';
import 'local_data_source.dart';

class LocalDataSourceImp extends ProductLocalDataSource {
  final SharedPreferences sharedpreferences;

  LocalDataSourceImp(this.sharedpreferences);

  static const String _cacheKey = 'Cached_products';

  @override
  Future<List<ProductModel>> getlastProducts() {
    final value = sharedpreferences.getString(_cacheKey);

    if (value != null) {
      final decode = jsonDecode(value) as List;
      return Future.value(decode.map((e) => ProductModel.fromJson(e)).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(List<ProductModel> products) async {
    final encode = jsonEncode(products.map((e) => e.toJson()).toList());
    await sharedpreferences.setString(_cacheKey, encode);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final productList = await getlastProducts();
      return productList.firstWhere((e) => e.id == id);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> addProduct(Product product) async {
    final productModel = product as ProductModel;

    final productList = await getlastProducts().catchError((_) => <ProductModel>[]);

    productList.add(productModel);

    final updatedJson = jsonEncode(productList.map((e) => e.toJson()).toList());
    final success = await sharedpreferences.setString(_cacheKey, updatedJson);

    if (success) {
      return productModel;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> updateProduct(int id, Product product) async {
    final productList = await getlastProducts();

    final index = productList.indexWhere((item) => item.id == id);

    if (index != -1) {
      final updatedProduct = product as ProductModel;
      productList[index] = updatedProduct;

      final updatedJson = jsonEncode(productList.map((e) => e.toJson()).toList());
      await sharedpreferences.setString(_cacheKey, updatedJson);

      return updatedProduct;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> deleteProduct(int id) async {
    final productList = await getlastProducts();

    final index = productList.indexWhere((item) => item.id == id);

    if (index != -1) {
      final deletedProduct = productList.removeAt(index);

      final updatedJson = jsonEncode(productList.map((e) => e.toJson()).toList());
      await sharedpreferences.setString(_cacheKey, updatedJson);

      return deletedProduct;
    } else {
      throw CacheException();
    }
  }
}
