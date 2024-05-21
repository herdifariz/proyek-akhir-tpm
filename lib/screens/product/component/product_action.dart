import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/cart.dart';
import '../../../models/product_model.dart';

class ProductActions extends StatelessWidget {
  final Products productData;

  ProductActions({required this.productData});

  Future<void> addToCart(Products productData) async {
    final box = await Hive.openBox<Cart>('cartBox'); // Open the 'cartBox'

    // Create a Cart object from the product data
    final cartItem = Cart(productData.title!, productData.price!.toDouble());

    // Add the cart item to the box
    await box.add(cartItem);

    // Print the contents of the box to the console
    print('Current cart contents:');
    box.values.forEach((item) {
      print('Name: ${item.name}, Price: ${item.price}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0, // Height of the button
      child: ElevatedButton(
        onPressed: () {
          // Implement add to cart functionality here
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Successfully added to cart!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      addToCart(productData);
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Background color of the button
          foregroundColor: Colors.purple, // Text color of the button
          textStyle: TextStyle(fontSize: 18.0),
        ),
        child: Text('Add to Cart'),
      ),
    );
  }
}
