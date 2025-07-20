class Product {
  String Name;
  String Description;
  double price;

  Product({required this.Name, required this.Description, required this.price});

  //setter
  set setName(String name) => this.Name = name;

  set setDescription(String description) => this.Description = description;

  set setPrice(double price) => this.price = price;

  //getter
  String get getName => this.Name;

  String get getDescription => this.Description;

  double get getPrice => this.price;
}
