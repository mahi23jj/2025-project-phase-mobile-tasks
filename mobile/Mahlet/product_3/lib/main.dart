import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 // 🔥 Required for BlocProvider

import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/Description/screen/description.dart';
import 'features/product/presentation/pages/Home/screen/Home_page.dart';
import 'features/product/presentation/pages/ProductForm/screen/Add_productForm.dart';
import 'features/product/presentation/pages/ProductForm/screen/Edit_productForm.dart';
import 'features/product/presentation/pages/Search/screen/search.dart';
import 'features/product/presentation/bloc/product_bloc.dart'; // ✅ Add this if not already
import 'features/product/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => di.sl<ProductBloc>()..add(LoadAllProductsEvent()),
      child: MaterialApp(
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
          primaryColor: const Color.fromRGBO(63, 81, 243, 1),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
      ),
    );
  }
}

PageRoute _buildPageRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionsBuilder: (_, animation, __, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
