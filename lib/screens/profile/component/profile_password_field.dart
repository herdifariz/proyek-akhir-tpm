import 'package:flutter/material.dart';

class ProfilePasswordField extends StatefulWidget {
  @override
  _ProfilePasswordFieldState createState() => _ProfilePasswordFieldState();
}

class _ProfilePasswordFieldState extends State<ProfilePasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Password : ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        Expanded(
          child: Text(
            _isPasswordVisible ? 'UserPassword123' : '********',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ],
    );
  }
}
