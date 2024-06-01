import 'package:flutter/material.dart';
import 'package:proyek/screens/kesanpesan/saran.dart';
import 'package:proyek/screens/login/login_page.dart';
import 'package:proyek/screens/settings/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/sidebar_app_bar.dart';
import 'component/user_info.dart';
import 'component/sidebar_item.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SidebarAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: UserInfo(),
          ),
          SidebarItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
          SidebarItem(
            icon: Icons.article,
            text: 'Saran dan Kesan',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KesanPesanPage()),
                );
            },
          ),
          SidebarItem(
            icon: Icons.logout_rounded,
            text: 'Logout',
            onTap: () async {
              late SharedPreferences logindata;
              logindata = await SharedPreferences.getInstance();
              logindata.setBool('login', true);

              Navigator.pushReplacement(
                  context, new MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
