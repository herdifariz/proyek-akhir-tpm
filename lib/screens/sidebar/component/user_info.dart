import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';

class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late Box<User> userBox;
  late SharedPreferences logindata;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    openUserBox();
  }

  Future<void> openUserBox() async {
    logindata = await SharedPreferences.getInstance();
    int? accIndex = logindata.getInt("accIndex");
    userBox = await Hive.openBox<User>('userBox');
    setState(() {
      currentUser = userBox.getAt(accIndex!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.white,
          child: Image.file(File(currentUser!.avatar!)),
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentUser!.name, style: TextStyle(color: Colors.white, fontSize: 20.0)),
            SizedBox(height: 8.0),
            Text(currentUser!.phone, style: TextStyle(color: Colors.white)),
            SizedBox(height: 4.0),
            Text(currentUser!.email, style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
