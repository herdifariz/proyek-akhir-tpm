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
    // Open the Hive box and fetch the current user data
    openUserBox();
  }

  Future<void> openUserBox() async {
    logindata = await SharedPreferences.getInstance();
    // String? email = logindata.getString('email');
    int? accIndex = logindata.getInt("accIndex");
    userBox = await Hive.openBox<User>('userBox');
    setState(() {
      // currentUser = userBox.values.firstWhere((user)=> user.email == email);
      currentUser = userBox.getAt(accIndex!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 60.0, // Memperbesar ukuran lingkaran
          backgroundColor: Colors.white,
          // child: Text("Foto", style: TextStyle(fontSize: 24.0)),
          child: Image.file(File(currentUser!.avatar!)),
        ),
        SizedBox(width: 20.0), // Jarak antara foto dan teks
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentUser!.name, style: TextStyle(color: Colors.white, fontSize: 20.0)), // Ganti dengan nama pengguna
            SizedBox(height: 8.0),
            Text(currentUser!.phone, style: TextStyle(color: Colors.white)), // Ganti dengan nomor telepon
            SizedBox(height: 4.0),
            Text(currentUser!.email, style: TextStyle(color: Colors.white)), // Ganti dengan alamat email
          ],
        ),
      ],
    );
  }
}
