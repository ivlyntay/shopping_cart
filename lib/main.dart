import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/login_page.dart';
import 'screens/catalog_page.dart';
import 'screens/cart_page.dart';
import 'models/cart.dart';
import 'models/catalog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatalogModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp.router(
        title: 'Shopping Cart',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF6B4F2A), // Brown
            brightness: Brightness.light,
            primary: Color(0xFF6B4F2A),
            background: Color(0xFFF8F5F1), // Cream
            surface: Colors.white,
          ),
          scaffoldBackgroundColor: Color(0xFFF8F5F1),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xFFF8F5F1),
            foregroundColor: Color(0xFF6B4F2A),
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B4F2A),
            ),
            titleLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B4F2A),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: '/catalog',
              builder: (context, state) => const CatalogPage(),
            ),
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartPage(),
            ),
          ],
        ),
      ),
    );
  }
}
