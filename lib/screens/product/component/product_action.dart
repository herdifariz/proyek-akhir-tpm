import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart.dart';
import '../../../models/product_model.dart';

class ProductActions extends StatefulWidget {
  final Products productData;

  ProductActions({required this.productData});

  @override
  _ProductActionsState createState() => _ProductActionsState();
}

class _ProductActionsState extends State<ProductActions> {
  String _selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences when the widget is initialized
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('selectedCurrency') ?? 'USD';
    });
  }

  double _convertCurrency(double priceInUSD) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return priceInUSD * 16000;
      case 'EUR':
        return priceInUSD * 0.92;
      default:
        return priceInUSD;
    }
  }

  String _formatPrice(double price) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return 'Rp ${price.toStringAsFixed(0)}';
      case 'EUR':
        return '€${price.toStringAsFixed(2)}';
      default:
        return '\$${price.toStringAsFixed(2)}';
    }
  }

  Future<void> addToCart(Products productData) async {
    final box = await Hive.openBox<Cart>('cartBox'); // Open the 'cartBox'

    // Convert the product price to the selected currency
    double convertedPrice = _convertCurrency(productData.price!.toDouble());

    // Create a Cart object from the product data with the converted price
    final cartItem = Cart(productData.title!, productData.price! as double);

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
    double convertedPrice = _convertCurrency(widget.productData.price!.toDouble());

    return SizedBox(
      height: 60.0, // Height of the button
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Successfully added to cart!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      addToCart(widget.productData);
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
