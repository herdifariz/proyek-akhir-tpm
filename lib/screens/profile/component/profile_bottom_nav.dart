import 'package:flutter/material.dart';

class ProfileBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ProfileBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _ProfileBottomNavState createState() => _ProfileBottomNavState();
}

class _ProfileBottomNavState extends State<ProfileBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        widget.onItemTapped(index);
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/wishlist');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/profile');
        }
      },
    );
  }
}
