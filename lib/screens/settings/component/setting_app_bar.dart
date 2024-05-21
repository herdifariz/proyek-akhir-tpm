import 'package:flutter/material.dart';

class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;

  const SettingAppBar({Key? key, required this.onPressed}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
        onPressed: onPressed,
      ),
      title: Text(
        'Setting',
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
