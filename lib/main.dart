import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyek/models/user.dart';
import 'package:proyek/models/wishlist.dart';
import 'package:proyek/screens/home/home_page.dart';
import 'package:proyek/screens/profile/profile.dart';
import 'package:proyek/screens/wishlist/wishlist_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import the notifications package
import 'models/cart.dart';
import 'screens/login/login_page.dart';
import 'screens/register/register_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters before opening boxes
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(WishlistAdapter());

  await Hive.openBox<User>('userBox');
  await Hive.openBox<Cart>('cartBox');
  await Hive.openBox<Wishlist>('wishListBox');

  // Initialize the notifications plugin
  initializeNotifications();

  runApp(MyApp());
}

void initializeNotifications() async {
  final InitializationSettings initializationSettings =
  InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
