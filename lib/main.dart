import 'package:flutter/material.dart';
import 'package:proyek/screens/home/home_page.dart';
import 'package:proyek/screens/order/order_track.dart';
import 'package:proyek/screens/profile/profile.dart';
import 'package:proyek/screens/settings/setting.dart';
import 'package:proyek/screens/wishlist/wishlist.dart';
import 'screens/login/login_page.dart';
import 'screens/register/register_page.dart';
import 'screens/product/product_page.dart';
import 'screens/sidebar/sidebar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/wishlist': (context) => WishlistPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
