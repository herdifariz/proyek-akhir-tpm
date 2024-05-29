import 'package:flutter/material.dart';

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
          icon: Icon(Icons.delete),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
