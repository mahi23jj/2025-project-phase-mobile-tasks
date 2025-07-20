import 'product.dart';
import 'product_manager.dart';
import 'dart:io';

String Stringinput(String prompt) {
  while (true) {
    stdout.write(prompt);
    var input = stdin.readLineSync();

    // Check if input is not null or empty
    if (input == null || input.trim().isEmpty) {
      print("Input cannot be empty. Try again.");
    } else {
      return input;
    }
  }
}


double doubleInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? value = stdin.readLineSync();

    // Check if input is not null or empty
    if (value != null && value.trim().isNotEmpty) {
      try {
        return double.parse(value);
      } catch (e) {
        print('Please enter a valid double value.');
      }
    } else {
      print('Input cannot be empty. Try again.');
    }
  }
}

int IntInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? value = stdin.readLineSync();

    // Check if input is not null or empty
    if (value != null && value.trim().isNotEmpty) {
      try {
        return int.parse(value);
      } catch (e) {
        print('Please enter a valid integer value');
      }
    } else {
      print('Input cannot be empty. Try again.');
    }
  }
}

void Menu(ProductManager manager) {
  while (true) {
    print(' Product Manager Menu:');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Single Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');

    int Choose = IntInput('Enter your choice: '); 

    switch (Choose) {
      case 1:
        var name = Stringinput('Name: ');

        var desc = Stringinput('Discription: ');

        var price = doubleInput('Price: ');
        manager.addProduct(
          Product(Name: name, Description: desc, price: price),
        );
        break;

      case 2:
        manager.viewallProducts();
        break;

      case 3:

        var name = Stringinput('Enter product name to view: ');
        manager.viewsingleProduct(name);
        break;

      case 4:
       
        var name = Stringinput('Enter product name you want to edit: ');
        var newName = Stringinput('New name: ');
        var newDesc = Stringinput('New description: ');
        var newPrice = doubleInput('New price: ');
        manager.editproduct(name, newName, newPrice, newDesc);
        break;

      case 5:

        var name = Stringinput('Enter product name you want to delete: ');
        manager.deleteProduct(name);
        break;

      case 6:
        return;

      default:
        print('Invalid');
    }
  }
}

void main() {
  var manager = ProductManager();
  // to control the flow of the program
  Menu(manager);
}
