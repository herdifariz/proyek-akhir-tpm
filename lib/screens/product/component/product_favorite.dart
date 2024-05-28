import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../models/product_model.dart';
import '../../../models/wishlist.dart';

class ProductFavorite extends StatefulWidget {
  final Function() onPressed;
  final String title;
  final double price;
  final String imageUrl;
  final Products productData; // Add this to provide product data

  const ProductFavorite({
    required this.onPressed,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productData, required bool isFavorited, // Add this to provide product data
  });

  @override
  _ProductFavoriteState createState() => _ProductFavoriteState();
}

class _ProductFavoriteState extends State<ProductFavorite> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    final box = await Hive.openBox<Wishlist>('wishListBox');
    final items = box.values.where((item) => item.name == widget.title).toList();
    if (items.isNotEmpty) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  Future<void> _addToWishlist() async {
    final box = await Hive.openBox<Wishlist>('wishListBox');
    final wishListItem = Wishlist(widget.title, widget.price, widget.imageUrl);
    await box.add(wishListItem);
    setState(() {
      isFavorited = true;
    });
  }

  Future<void> _removeFromWishlist() async {
    final box = await Hive.openBox<Wishlist>('wishListBox');
    final items = box.values.where((item) => item.name == widget.title).toList();
    for (var item in items) {
      await box.delete(item.key);
    }
    setState(() {
      isFavorited = false;
    });
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
