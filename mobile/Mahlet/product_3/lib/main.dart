import 'package:flutter/material.dart';

import 'features/product/presentation/pages/Description/screen/Discription.dart';
import 'features/product/presentation/pages/Home/screen/Home_page.dart';
import 'features/product/presentation/pages/ProductForm/screen/Add_productForm.dart';
import 'features/product/presentation/pages/ProductForm/screen/Edit_productForm.dart';
import 'features/product/presentation/pages/screen/search.dart';
import 'features/product/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/edit':
            page = const EditFormpage();
            break;
          case '/search':
            page = Searchpage();
            break;
          case '/description':
            page = const Description();
            break;
          case '/productform':
            page = const ProductFormPage();
            break;
          default:
            page = const Homepage();
            break;
        }
        return _buildPageRoute(page, settings);
      },

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(63, 81, 243, 1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      //
    );
  }
}

PageRoute _buildPageRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: Offset(1.0, 0.0), // from right
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
