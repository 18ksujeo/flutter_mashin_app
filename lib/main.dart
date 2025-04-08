import 'package:flutter/material.dart';
import 'package:flutter_mashin_app/details/ui/product_detail_screen.dart';
import 'package:flutter_mashin_app/cart/ui/cart_screen.dart';
import 'package:flutter_mashin_app/list/logic/ProductListProvider.dart';
import 'package:flutter_mashin_app/purchase/ui/purchase_history_screen.dart';
import 'package:flutter_mashin_app/storage/product_storage.dart';
import 'package:provider/provider.dart';
import 'auth/logic/auth_provider.dart';
import 'auth/ui/login_screen.dart' as login;
import 'auth/ui/signup_screen.dart';
import 'auth/ui/splash_screen.dart';
import 'package:flutter_mashin_app/add/ui/add_product_screen.dart';
import 'package:flutter_mashin_app/home/logic/user_provider.dart';
import 'package:flutter_mashin_app/home/widgets/menu_bar.dart';
import 'package:flutter_mashin_app/cart/logic/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProductStorage.init(); // Initialize local storage
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductListProvider()),  // Add ProductListProvider
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
        '/cart': (context) => CartScreen(),
        '/purchase_history': (context) => const PurchaseHistoryScreen(),
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/product_detail':
            if (args is Map<String, dynamic>) {
              final rawPrice = args['price'];
              final price = rawPrice is int ? rawPrice.toDouble() : double.tryParse(rawPrice.toString()) ?? 0.0;
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
