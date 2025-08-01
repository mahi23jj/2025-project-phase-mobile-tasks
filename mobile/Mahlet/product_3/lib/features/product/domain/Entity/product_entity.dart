import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String id;
  String imageurl;
  String title;
  String discription;
  double price;


  Product({
    this.id = '',
   required  this.imageurl,
    required this.title,
    required this.price,
    required this.discription,
  });

  @override
  List<Object?> get props => [id, imageurl, title, price, discription];
}