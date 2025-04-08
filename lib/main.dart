import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/ui/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'auth/logic/auth_provider.dart';
import 'auth/ui/login_screen.dart' as login;
import 'auth/ui/signup_screen.dart';
import 'auth/ui/splash_screen.dart';
import 'package:flutter_mashin_app/add/ui/add_product_screen.dart';
import 'package:flutter_mashin_app/home/logic/user_provider.dart';
import 'package:flutter_mashin_app/home/widgets/menu_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마교 쇼핑몰',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const login.LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MenuScaffold(),
        '/add_product': (context) => const AddProductScreen(),
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/product_detail':
            if (args is Map<String, dynamic>) {
              final price = int.tryParse(args['price'].toString()) ?? 0; // Safely convert price to int
              return MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  productName: args['productName'],
                  imageUrl: args['imageUrl'],
                  description: args['description'],
                  price: price,  // Pass the correctly parsed price
                ),
              );
            }
            return null;
          default:
            return null;
        }
      },
    );
  }
}
