import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../screens/home/home_page.dart';

class LoginController {
  late SharedPreferences logindata;

  void login(BuildContext context, String email, String password) async {
    final usersBox = await Hive.openBox<User>('userBox');

    logindata = await SharedPreferences.getInstance();
    // Inisialisasi variabel untuk menampung user yang ditemukan dan indeksnya
    User? foundUser;
    int userIndex = 0; // Inisialisasi default ke 0

<<<<<<< HEAD
    // Iterasi melalui box untuk menemukan user dengan email yang diberikan
    for (int i = 0; i < usersBox.length; i++) {
      final user = usersBox.getAt(i);
      if (user != null && user.email == email) {
        foundUser = user;
        logindata.setInt("accIndex", i);
        break;
      }
    }

    // Periksa apakah user ada dan password cocok
    if (foundUser != null && foundUser.password == password) {
      print('Login berhasil!');
      //logindata = await SharedPreferences.getInstance();
      logindata.setBool('login', true);  // Mengasumsikan true berarti sudah login
=======
    // Check if the user exists and the password matches
    if (user != null && user.password == password) {
      print('Login successful!');
      logindata = await SharedPreferences.getInstance();
      logindata.setBool('login', false);
      logindata.setString('email', email);
      // print(logindata.getString('email'));
>>>>>>> 5e235e2c20f29e41506f4c4efe2e4ffa8cc21e44
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Silakan periksa input Anda dan coba lagi.'),
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
      print('Email atau password salah. Login gagal.');
    }
  }
}
