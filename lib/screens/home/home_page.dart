import 'package:flutter/material.dart';
import 'component/home_app_bar.dart';
import 'component/home_bottom_nav.dart';
import 'component/home_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/wishlist');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(isProductByCategory:false, ),
      body: HomeCategoryData(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
