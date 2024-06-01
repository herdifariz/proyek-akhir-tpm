import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../kesanpesan/saran.dart';
import '../login/login_page.dart';
import '../settings/setting.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
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
    return Drawer(
      width: MediaQuery.of(context).size.width*0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: currentUser!.avatar == ''
                      ? Icon(
                          Icons.person,
                          size: 100,
                        )
                      : ClipOval(
                          child: Image.file(
                            File(currentUser!.avatar!),
                            fit: BoxFit.cover,
                            width: 180,
                            height: 180,
                          ),
                        ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(currentUser!.name,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    SizedBox(height: 8.0),
                    Text(currentUser!.phone,
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 4.0),
                    Text(currentUser!.address,
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Setting'),
            // selected: _selectedIndex == 0,
            onTap: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: const Text('Saran dan Kesan'),
            // selected: _selectedIndex == 1,
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => KesanPesanPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            // selected: _selectedIndex == 2,
            onTap: () async {
              late SharedPreferences logindata;
              logindata = await SharedPreferences.getInstance();
              logindata.setBool('login', true);

              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
