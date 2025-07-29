import '../../domain/Entity/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    super.id ,
    required super.imageurl,
    required super.title,
    required super.subtitle,
    required super.price,
    required super.discription,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      discription:json['discription'] ,
      id: json['id'],
      imageurl: json['imageurl'] ,
      price: (json['price'] as num).toDouble() ,
      subtitle: json['subtitle'] ,
      title: json['title'] ,
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageurl': imageurl,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'discription': discription,
    };
  }
}

