import 'product.dart';

class ProductManager {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
  }

  void display(Product product) {
    
    print('Name: ${product.Name}');
    print('Description: ${product.Description}');
    print('price: ${product.price}');
  }

  void viewallProducts() {
    if (products.isEmpty) {
      print('No products available');
      
    }else{
    for (var product in products) {
      display(product);
    }
    }
  }

  void viewsingleProduct(String name) {
    try {
      var product = products.firstWhere((Product) => Product.Name == name);
      display(product);
    } catch (e) {
      print('this product not found');
    }
  }

  void editproduct(String name, String newdescription, double newprice , String newname) {
    try {
      var product = products.firstWhere((Product) => Product.Name == name);
      product.Description = newdescription;
      product.price = newprice;
      product.Name = newname;
      display(product);
    } catch (e) {
      print('this product not found');
    }


  }

  void deleteProduct(String name) {
    try {
      var product = products.firstWhere((Product) {
        return Product.Name == name;
      });
      products.remove(product);
      display(product);
    } catch (e) {
      print('product not found');
    }
  }

}
