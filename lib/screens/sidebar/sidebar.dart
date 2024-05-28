import 'package:flutter/material.dart';
import 'package:proyek/screens/login/login_page.dart';
import 'package:proyek/screens/settings/setting.dart';
import 'package:proyek/screens/wishlist/wishlist_page.dart';
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
            icon: Icons.favorite,
            text: 'Wishlist',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistPage()),
              );
            },
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
            icon: Icons.person_2,
            text: 'Member',
            onTap: () {
              // Handle the tap
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
