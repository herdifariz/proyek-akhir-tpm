import 'package:flutter/material.dart';

class SidebarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;

  const SidebarAppBar({Key? key, required this.onPressed}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
