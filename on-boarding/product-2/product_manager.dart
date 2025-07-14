import 'product.dart';

class ProductManager {
  List<Product> products = [];


// add a product to the list
  void addProduct(Product product) {
    products.add(product);
    print('Product "${product.getName}" added.');
  }

  // inorder to display a products name,discription and price
  void display(Product product) {
    print('Name: ${product.getName}');
    print('Description: ${product.getDescription}');
    print('price: ${product.getPrice}');
  }

 // to display all products
  void viewallProducts() {
    if (products.isEmpty) {
      print('No products available');
    } else {
      for (var product in products) {
        display(product);
      }
    }
  }

// inorder to view a single product 
  void viewsingleProduct(String name) {
    try {
      var product = products.firstWhere((Product) => Product.getName == name);
      display(product);
    } catch (e) {
      print('this product not found');
    }
  }

// inorder to edit a product name,discription and price
  void editproduct(
    String name,
    String newdescription,
    double newprice,
    String newname,
  ) {
    try {
      var product = products.firstWhere((Product) => Product.getName == name);
      product.setDescription = newdescription;
      product.setPrice = newprice;
      product.setName = newname;
      display(product);
    } catch (e) {
      print('this product not found');
    }
  }

// inorder to remove a product from the list    
  void deleteProduct(String name) {
    try {
      var product = products.firstWhere((Product) {
        return Product.getName == name;
      });
      products.remove(product);
      display(product);
    } catch (e) {
      print('product not found');
    }
  }
}
