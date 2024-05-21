import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have an account? ",
        children: [
          TextSpan(
            text: 'Create a new account',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/register');
              },
          ),
        ],
      ),
    );
  }
}
