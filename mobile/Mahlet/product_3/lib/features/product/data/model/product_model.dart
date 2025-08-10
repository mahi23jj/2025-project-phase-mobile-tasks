import '../../domain/Entity/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    super.id,
    required super.imageurl,
    required super.title,
    required super.price,
    required super.discription,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['name'] as String,
      discription: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageurl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': discription,
      'price': price,
      'imageUrl': imageurl,
    };
  }
}
