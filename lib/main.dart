import 'pages/register.dart';
import 'pages/user/cart_page.dart';
import 'pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'pages/login.dart';
import 'pages/admin/admin_home_page.dart';
import 'pages/user/user_home_page.dart';
import 'package:bakery_store/provider/auth_provider.dart';
import 'package:bakery_store/provider/product_provider.dart';
import 'pages/admin/product_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Aktifkan Device Preview
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => AuthProvider()), // Tambahkan AuthProvider
          ChangeNotifierProvider(
              create: (_) => ProductProvider()), // Tambahkan ProductProvider
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery Store',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/welcome', // Set initial route to WelcomePage
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/admin_home': (context) => AdminHomePage(),
        '/product_management': (context) => const ProductPage(),
        '/user_home': (context) => UserHomePage(),
        '/cart': (context) => const CartPage(),
      },
      home: const WelcomePage(),
    );
  }
}
