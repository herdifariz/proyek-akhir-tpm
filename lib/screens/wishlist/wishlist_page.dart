import 'package:flutter/material.dart';
import '../product/product_page.dart';
import '../sidebar/sidebar.dart';
import 'component/wishlist_item.dart';
import 'package:hive/hive.dart';
import 'package:proyek/models/wishlist.dart';
import 'package:proyek/models/product_model.dart'; // Impor model produk

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedIndex = 1;

  List<Wishlist> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    _loadWishlistItems();
  }

  Future<void> _loadWishlistItems() async {
    final box = await Hive.openBox<Wishlist>('wishListBox');
    setState(() {
      wishlistItems = box.values.toList();
    });
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
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.deepPurple),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sidebar()),
            );
          },
        ),
        title: Text('Wishlist', style: TextStyle(color: Colors.deepPurple)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.deepPurple),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: ListView.builder(
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigasi ke halaman detail produk
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProductPage(productData: wishlistItems),
                //   ),
                // );
              },
              child: WishlistItem(
                wishlistItem: wishlistItems[index],
                onRemove: () => _removeItemFromList(wishlistItems[index]), // Pass the callback
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: [
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
      ),
    );
  }
}
