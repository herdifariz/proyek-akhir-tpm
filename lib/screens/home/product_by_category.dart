import 'package:flutter/material.dart';
import 'package:proyek/screens/home/component/product_category_data.dart';

import 'component/home_app_bar.dart';
import 'component/home_bottom_nav.dart';


class ProductByCategoryPage extends StatefulWidget {
  final String categoryName;

  const ProductByCategoryPage({super.key, required this.categoryName});

  @override
  State<ProductByCategoryPage> createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
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
      appBar: HomeAppBar(),
      body: ProductCategoryData(categoryName: widget.categoryName,),
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
