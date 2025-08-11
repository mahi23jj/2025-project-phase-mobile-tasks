import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 // 🔥 Required for BlocProvider

import 'features/autentication/presentation/bloc/user_bloc.dart';
import 'features/autentication/presentation/pages/login_page.dart';
import 'features/autentication/presentation/pages/sign_up.dart';
import 'features/chat/presentation/Bloc/chat_bloc.dart';
import 'features/chat/presentation/Bloc/chat_event.dart';
import 'features/chat/presentation/page/contact_list.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/Description/screen/description.dart';
import 'features/product/presentation/pages/Home/screen/Home_page.dart';
import 'features/product/presentation/pages/ProductForm/screen/Add_productForm.dart';
import 'features/product/presentation/pages/ProductForm/screen/Edit_productForm.dart';
import 'features/product/presentation/pages/Search/screen/search.dart';
import 'features/product/presentation/bloc/product_bloc.dart'; // ✅ Add this if not already
import 'core/injection_container.dart' as di;
import 'socate_test_page.dart';
import 'test_sockate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // initialize dependencies
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color.fromRGBO(63, 81, 243, 1),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//       ),
//       home: SocketTestPage(),

      
//     );
//   }
//

// void main() async {
//   final webSocketService = WebSocketServicetest();

//   webSocketService.connect();

//   // Wait a bit to ensure connection is established
//   await Future.delayed(Duration(seconds: 2));

//   final sent = await webSocketService.sendMessage(
//     chatId: '6899c60e817e9a3287ca515f',
//     content: 'Hey you!',
//     type: 'text',
//   );

//   print(sent ? '✅ Message sent' : '❌ Failed to send message');

//   // Listen for incoming messages
//   webSocketService.messageStream.listen((message) {
//     print('📥 Incoming message: $message');
//   });

//   // Later, when you close app or no longer need socket:
//   webSocketService.dispose();
// }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<UserBloc>(
        create: (_) => di.sl<UserBloc>(),
      ),
      BlocProvider<ChatBloc>(
        create: (_) => di.sl<ChatBloc>()..add(Loadcontact()),
      ),
      // Add more BlocProviders here as needed
    ],
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
          case '/contacts':
            page = ContactList();
            break;
          case '/chat':
            page = const Description();
            break;
          case '/signin':
            page = const LoginPage();
            break;
          default:
            page = const SignupPage();
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
}