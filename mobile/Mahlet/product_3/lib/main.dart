import 'package:flutter/material.dart';
import 'package:product_3/Description/screen/Discription.dart';
import 'package:product_3/Home/screen/Home_page.dart';
import 'package:product_3/ProductForm/screen/productForm.dart';
import 'package:product_3/Search/screen/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(63, 81, 243, 1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: Homepage(),
    );
  }
}
