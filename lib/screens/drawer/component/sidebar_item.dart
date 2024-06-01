import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SidebarItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(text, style: TextStyle(color: Colors.deepPurple)),
      onTap: onTap,
    );
  }
}
