import 'package:flutter/material.dart';
import 'package:proyek/screens/sidebar/sidebar.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.deepPurple),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Sidebar()),
          );
        },
      ),
      title: Text(
        'Profile',
        style: TextStyle(color: Colors.deepPurple),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
