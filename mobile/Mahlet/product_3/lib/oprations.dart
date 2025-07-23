import 'domain/Entity/product_Entity.dart';

class Oprations {


  List<Product> Cards = [
    Product(
      id: 1,
      imageurl: 'asset/images/img1.jpg',
      price: '\$100',

      subtitle: 'Men’s shoe',
      title: 'Derby Leather Shoes',
      discription:
          'Lorem ipsum dolor sit amet, consectetur adipisc id lacinia nunc nunc id nunc. Sed euismod, nunc id aliquam tincidunt, nisl nunc tincidunt nunc, id lacinia nunc nunc id nunc.',
    ),
    Product(
      id: 2,
      imageurl: 'asset/images/img3.jpg',
      price: '\$110',

      subtitle: 'Womens’s shoe',
      title: 'chenoles Hill Shoes',
      discription: 'Lorem ipsum dolor sit amet, consectetur adipisci',
    ),
    Product(
      id: 3,
      imageurl: 'asset/images/img2.jpg',
      price: '\$200',

      subtitle: 'Children’s shoe',
      title: 'FAN KA HAO Shoes',
      discription:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc id aliquam tincidunt, nisl nunc tincidunt nunc, id lacinia nunc nunc id nunc. Sed euismod, nunc id aliquam tincidunt, nisl nunc tincidunt nunc, id lacinia nunc nunc id nunc.',
    ),
  ];

  // get cards

  /// add to cart
  void addToCart(Product Product) {
    Product.id = Cards.length + 1;
    Cards.add(Product);
  }

  /// remove from cart
  void removeFromCart(int id) {
    if (id > 0 && id <= Cards.length) {
      Cards.removeAt(id - 1);
    } else {
      throw Exception('Product with ID $id not found.');
    }
  }

  //Edit product
  void editproduct(int id, Product Product) {
    try {
      final index = Cards.indexWhere((product) => product.id == id);
      if (index != -1) {
        Cards[index] = Product;
      } else {
        throw Exception('Product with ID $id not found.');
      }
    } catch (e) {
      throw Exception('Product with ID $id not found.');
    }
  }
}
