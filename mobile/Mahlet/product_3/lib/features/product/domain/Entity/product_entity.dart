import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id;
  String imageurl;
  String title;
  String subtitle;
  String discription;
  double price;


  Product({
    this.id = 0,
   required  this.imageurl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.discription,
  });

  @override
  List<Object?> get props => [id, imageurl, title, subtitle, price, discription];
}