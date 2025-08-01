import 'features/product/domain/Entity/product_entity.dart';

class Oprations {
  List<Product> Cards = [
    Product(
      id: '1',
      imageurl: 'asset/images/img1.jpg',
      price: 100,

      title: 'Derby Leather Shoes',
      discription:
          'Lorem ipsum dolor sit amet, consectetur adipisc id lacinia nunc nunc id nunc. Sed euismod, nunc id aliquam tincidunt, nisl nunc tincidunt nunc, id lacinia nunc nunc id nunc.',
    ),
    Product(
      id: '2',
      imageurl: 'asset/images/img3.jpg',
      price: 110,

      title: 'chenoles Hill Shoes',
      discription: 'Lorem ipsum dolor sit amet, consectetur adipisci',
    ),
  ];

  // get cards

  /// add to cart
  void addToCart(Product Product) {
    // Product.id = Cards.length + 1;
    // Cards.add(Product);
  }

  /// remove from cart
  void removeFromCart(String id) {
    // if (id > 0 && id <= Cards.length) {
    //   Cards.removeAt(id - 1);
    // } else {
    //   throw Exception('Product with ID $id not found.');
    // }
  }

  //Edit product
  void editproduct(String id, Product Product) {
    // try {
    //   final index = Cards.indexWhere((product) => product.id == id);
    //   if (index != -1) {
    //     Cards[index] = Product;
    //   } else {
    //     throw Exception('Product with ID $id not found.');
    //   }
    // } catch (e) {
    //   throw Exception('Product with ID $id not found.');
    // }
  }
}
