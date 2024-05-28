import 'package:flutter/material.dart';
import 'package:proyek/screens/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/login_header.dart';
import 'component/login_form.dart';
import 'component/login_footer.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

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
