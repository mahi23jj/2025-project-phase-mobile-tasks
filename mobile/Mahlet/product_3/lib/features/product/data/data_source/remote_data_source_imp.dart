import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/Error/exception.dart';
import '../../domain/Entity/product_entity.dart';
import '../model/product_model.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImp extends ProductRemoteDataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  Future<List<ProductModel>> getAllProduct() async {
    final result = await client.get(
      headers: {'Content-Type': 'application/json'},
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
    );

    if (result.statusCode == 200) {
      return List<ProductModel>.from(
        jsonDecode(result.body).map((x) => ProductModel.fromJson(x)).toList(),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final result = await client.get(
      headers: {'Content-Type': 'application/json'},
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );

    if (result.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(result.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct(Product product) async {

     final productMap = product as ProductModel;
  final result = jsonEncode(productMap.toJson());

    final response = await client.post(
      Uri.parse('https://fakestoreapi.com/products'),
      body: result,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(int id, Product product) async{
     final productMap = product as ProductModel;
  final result = jsonEncode(productMap.toJson());

   final response = await client.put(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    body:result ,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }


   
  }

  @override
  Future<void> deleteProduct(int id) async{
    final response = await client.delete(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
    }else{
      throw ServerException();
    }
  }
}
