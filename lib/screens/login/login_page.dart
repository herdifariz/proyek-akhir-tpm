import 'package:flutter/material.dart';
import 'component/login_header.dart';
import 'component/login_form.dart';
import 'component/login_footer.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              LoginHeader(),
              Spacer(),
              LoginForm(),
              Spacer(),
              LoginFooter(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
