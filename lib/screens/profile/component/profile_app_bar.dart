import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/login_page.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  ProfileAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Profile'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            late SharedPreferences logindata;
            logindata = await SharedPreferences.getInstance();
            logindata.setBool('login', true);

            Navigator.pushReplacement(
                context, new MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
