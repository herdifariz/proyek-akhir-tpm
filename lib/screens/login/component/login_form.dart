import 'package:flutter/material.dart';
import '../../../controllers/login_controller.dart';
import '../../home/home_page.dart';

class LoginForm extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFF6200EE)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline ungu
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline ungu saat fokus
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline default
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color(0xFF6200EE)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline ungu
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline ungu saat fokus
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6200EE)), // Warna outline default
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            obscureText: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              loginController.login(
                  context, emailController.text, passwordController.text);
            },
            child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6200EE), // Warna tombol ungu
              minimumSize: Size(double.infinity, 50), // Lebar tombol penuh
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
