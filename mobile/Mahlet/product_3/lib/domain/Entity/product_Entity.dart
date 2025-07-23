class Product {
  int id;
  String imageurl;
  String title;
  String subtitle;
  String discription;
  String price;


  Product({
    this.id = 0,
   required  this.imageurl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.discription,
  });
}