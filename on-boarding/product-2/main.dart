import 'product.dart';
import 'product_manager.dart';
import 'dart:io';

void main() {
  var manager = ProductManager();

  while (true) {
    
    print(' Product Manager Menu:');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Single Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');

    stdout.write('Choose an option: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        stdout.write('Name: ');
        var name = stdin.readLineSync()!;
        stdout.write('Description: ');
        var desc = stdin.readLineSync()!;
        stdout.write('Price: ');
        var price = double.parse(stdin.readLineSync()!);
        manager.addProduct(
          Product(Name: name, Description: desc, price: price),
        );
        break;

      case '2':
        manager.viewallProducts();
        break;

      case '3':
        stdout.write('Enter product name to view: ');
        var name = stdin.readLineSync()!;
        manager.viewsingleProduct(name);
        break;

      case '4':
        stdout.write('Enter product name you want to edit: ');
        var name = stdin.readLineSync()!;
        stdout.write('New name: ');
        var newName = stdin.readLineSync()!;
        stdout.write('New description: ');
        var newDesc = stdin.readLineSync()!;
        stdout.write('New price: ');
        var newPrice = double.parse(stdin.readLineSync()!);
        manager.editproduct(name, newName, newPrice, newDesc);
        break;

      case '5':
        stdout.write('Enter product name you want to delete: ');
        var name = stdin.readLineSync()!;
        manager.deleteProduct(name);
        break;

      case '6':
        return;

      default:
        print('Invalid');
    }
  }
}
