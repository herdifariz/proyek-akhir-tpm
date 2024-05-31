import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek/models/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/wishlist.dart';
import '../screens/login/login_page.dart';

class RegisterController {
  late SharedPreferences registerData;
  void register(BuildContext context, String name, String city, String address,
      String phone, String email, String password, List<Cart> carts, List<Wishlist> wishlists, String? avatar) async {
    final usersBox = await Hive.openBox<User>('userBox');
    registerData = await SharedPreferences.getInstance();

    // Check if email already exists
    final userExists = usersBox.values.any((user) => user.email == email);
    if (userExists) {
      print('Email already exists!');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Email already exists!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    User newUser = User(
      name,
      city,
      address,
      phone,
      email,
      hashedPassword,
      carts,
      wishlists,
      avatar
    );

    await usersBox.add(newUser);

    // registerData = await SharedPreferences.getInstance();
    int userCount = usersBox.length;
    await registerData.setInt("accIndex", userCount-1);
    await registerData.setBool("logedIn", true);

    print('Register successful!');
    for (var user in usersBox.values) {
      print(
          'Name: ${user.name}, Email: ${user.email}, City: ${user.city}, Address: ${user.address}, Phone: ${user.phone}, Password: ${user.password}');
    }

    // Lanjutkan ke halaman login
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
