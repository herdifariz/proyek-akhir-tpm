import 'package:flutter/material.dart';
import 'package:proyek/screens/cart/cart_page.dart';
// import '../../sidebar/sidebar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProductByCategory;

  HomeAppBar({this.isProductByCategory = false,});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text("Electronic Shop"),
          // child: TextField(
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(), // Melewatkan selectedTimeZone ke CartPage
              ),
            );
          },
        ),
      ],
    );
  }
}

