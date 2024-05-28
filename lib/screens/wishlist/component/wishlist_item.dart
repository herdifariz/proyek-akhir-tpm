import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek/models/wishlist.dart';

class WishlistItem extends StatelessWidget {
  final Wishlist wishlistItem;
  final VoidCallback onRemove; // Add a callback for removing the item

  const WishlistItem({
    Key? key,
    required this.wishlistItem,
    required this.onRemove, // Initialize the callback
  }) : super(key: key);

  Future<void> _removeFromWishlist(BuildContext context, Wishlist item) async {
    final box = await Hive.openBox<Wishlist>('wishListBox');
    await box.delete(item.key);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item removed from wishlist')),
    );
    onRemove(); // Call the callback to update the state
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 150,
              alignment: Alignment.centerLeft,
              child: Image.network(
                wishlistItem.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wishlistItem.name,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${wishlistItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.deepPurple),
                        onPressed: () => _removeFromWishlist(context, wishlistItem),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
