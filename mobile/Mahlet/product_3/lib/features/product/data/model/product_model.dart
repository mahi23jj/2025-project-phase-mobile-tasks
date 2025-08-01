import '../../domain/Entity/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    super.id ,
    required super.imageurl,
    required super.title,
    required super.price,
    required super.discription,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['name'],                        // ← from 'name'
      discription: json['description'],           // ← from 'description'
      price: (json['price'] as num).toDouble(),   // ← price as double
      imageurl: json['imageUrl'],                 // ← from 'imageUrl'     
      );
  }

  Map<String, dynamic> toJson() {
    return {
       'id': id,
      'name': title,                // match the backend’s key
      'description': discription,
      'price': price,
      'imageUrl': imageurl,
    };
  }
}

