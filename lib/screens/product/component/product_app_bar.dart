import 'package:flutter/material.dart';
import 'package:proyek/screens/cart/cart_page.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
