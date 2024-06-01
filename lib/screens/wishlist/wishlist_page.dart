import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek/screens/cart/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import 'component/wishlist_item.dart';
import '../../models/wishlist.dart';
import '../../models/product_model.dart';
import '../product/product_page.dart';
// import '../sidebar/sidebar.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedIndex = 0;
  List<Wishlist> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    _loadWishlistItems();
  }

  Future<void> _loadWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? accIndex = prefs.getInt("accIndex");

    if (accIndex != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final User? currentUser = userBox.get(accIndex);

      if (currentUser != null) {
        setState(() {
          wishlistItems = currentUser.wishlists;
        });
      }
    }
  }

  void _removeItemFromList(Wishlist item) {
    setState(() {
      wishlistItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist', style: TextStyle(color: Colors.deepPurple)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => CartPage()));
            },
          )
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: wishlistItems.isNotEmpty
            ? ListView.builder(
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            return WishlistItem(
              wishlistItem: wishlistItems[index],
              onRemove: () => _removeItemFromList(wishlistItems[index]),
            );
          },
        )
            : Center(
          child: Text(
            "Wishlist Kosong",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
