import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '../../../models/product_model.dart';
import '../../../models/wishlist.dart';
import '../../../models/user.dart'; // Import User model

class ProductFavorite extends StatefulWidget {
  final Function() onPressed;
  final String title;
  final double price;
  final String imageUrl;
  final Products productData;
  final bool isFavorited;

  const ProductFavorite({
    required this.onPressed,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productData,
    required this.isFavorited,
  });

  @override
  _ProductFavoriteState createState() => _ProductFavoriteState();
}

class _ProductFavoriteState extends State<ProductFavorite> {
  bool isFavorited = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    isFavorited = widget.isFavorited;
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _addToWishlist() async {
    int? accIndex = prefs.getInt("accIndex");
    if (accIndex != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final currentUser = userBox.get(accIndex);
      if (currentUser != null) {
        final wishListItem = Wishlist(widget.title, widget.price, widget.imageUrl);
        currentUser.wishlists.add(wishListItem);
        userBox.put(accIndex, currentUser);
        setState(() {
          isFavorited = true;
        });
      }
    }
  }

  Future<void> _removeFromWishlist() async {
    int? accIndex = prefs.getInt("accIndex");
    if (accIndex != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final currentUser = userBox.get(accIndex);
      if (currentUser != null) {
        final items = currentUser.wishlists.where((item) => item.name == widget.title).toList();
        for (var item in items) {
          currentUser.wishlists.remove(item);
        }
        userBox.put(accIndex, currentUser);
        setState(() {
          isFavorited = false;
        });
      }
    }
  }

  void _toggleFavorite() {
    if (isFavorited) {
      _removeFromWishlist();
    } else {
      _addToWishlist();
    }
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.red : Colors.white,
      ),
      onPressed: () {
        _toggleFavorite();
      },
    );
  }
}
