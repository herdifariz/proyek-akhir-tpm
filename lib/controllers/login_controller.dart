import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../screens/home/home_page.dart';

class LoginController {
  late SharedPreferences logindata;

  void login (BuildContext context, String email, String password) async {
    final usersBox = await Hive.openBox<User>('userBox');

    // Find the user with the provided email
    final user = usersBox.values.firstWhere(
          (user) => user.email == email,
      orElse: () => null!,
    );

    // Check if the user exists and the password matches
    if (user != null && user.password == password) {
      print('Login successful!');
      logindata = await SharedPreferences.getInstance();
      logindata.setBool('login', false);
      logindata.setString('email', email);
      // print(logindata.getString('email'));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Please check your input and try again.'),
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
      print('Invalid email or password. Login failed.');
    }
  }
}