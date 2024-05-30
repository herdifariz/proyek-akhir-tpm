import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product_model.dart';
import '../../models/user.dart';
import '../order/order_track.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<DateTime> _flaggedTimes = [];
  String _selectedTimeZone = 'UTC+0:00 London';
  String _selectedCurrency = 'Rupiah';

  User? user;

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences when the page is initialized
    loadCart(); // Load the user's cart when the page is initialized
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedTimeZone = prefs.getString('selectedTimeZone') ?? 'UTC+0:00 London';
      _selectedCurrency = prefs.getString('selectedCurrency') ?? 'Rupiah';
    });
  }

  void loadCart() async {
    var userBox = await Hive.openBox<User>('userBox');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? accIndex = prefs.getInt("accIndex");

    if (accIndex != null) {
      User? currentUser = userBox.get(accIndex);
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // Set background color to deep purple
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: Container(
        color: Colors.deepPurple, // Ensure the background color is deep purple
        child: user != null
            ? _buildCartList()
            : Center(child: CircularProgressIndicator()), // Show cart list if user is loaded, else show loading indicator
      ),
    );
  }

  Widget _buildCartList() {
    return Container(
      color: Colors.deepPurple, // Set the background color of the whole list to deep purple
      child: Column(
        children: [
          Expanded(
            child: user!.carts.isNotEmpty
                ? ListView.builder(
              itemCount: user!.carts.length,
              itemBuilder: (context, index) {
                final cartItem = user!.carts[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color of the product container to white
                    borderRadius: BorderRadius.circular(12), // Add rounded border
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add some margin for spacing
                  padding: EdgeInsets.all(16), // Add padding inside the container
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.name,
                            style: TextStyle(
                              color: Colors.deepPurple, // Set the text color to purple
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price: ${_formatPrice(_convertCurrency(cartItem.price))}',
                                style: TextStyle(
                                  color: Colors.deepPurple, // Set the text color to purple
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDeleteConfirmationDialog(context, index);
                                },
                                child: Icon(Icons.delete, color: Colors.red, size: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
                : Center(child: Text('No items in cart', style: TextStyle(color: Colors.white))),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${_calculateTotalPrice()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the text color to white
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _checkout(context); // Call checkout function and wait for the dialog to close
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the background color of the button to white
                    foregroundColor: Colors.deepPurple, // Set the text color of the button to purple
                  ),
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete from Cart?'),
        content: Text('Are you sure you want to remove this item from your cart?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _removeFromCart(index); // Remove the item from cart
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void _removeFromCart(int index) {
    setState(() {
      user!.carts.removeAt(index);
    });
  }

  Future<void> _checkout(BuildContext context) async {
    // Convert current time to selected time zone before adding to flaggedTimes
    DateTime flaggedTime = DateTime.now().toUtc().add(_getDuration(_selectedTimeZone));
    _flaggedTimes.add(flaggedTime);

    // Call function to flag time according to selected timezone
    _flagTimeAccordingToTimeZone();

    // Show a dialog with the total amount and a close button
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Anda Yakin Akan Membeli?'),
          content: Text('Total amount: ${_calculateTotalPrice()}'),
          actions: [
          ElevatedButton(
          onPressed: () {
              Navigator.pop(context);
              Navigator.push(
              context,
              MaterialPageRoute(
                      builder: (context) => OrderTrackingPage(
                          flaggedTime: _flaggedTimes, totalHarga: _calculateTotalPrice(), // Pass the flagged time here
                        ),
                      ),
                      );
                      // _clearCart();
                      },
            child: Text('Ya'),
            ),
            TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Tidak'),
            ),
          ],
      ),
    );
  }

  void _flagTimeAccordingToTimeZone() {
    Random random = Random();
    _flaggedTimes.forEach((time) {
      int randomMinutes = random.nextInt(26) + 5; // Generate a random number between 5 and 30
      Duration randomDuration = Duration(minutes: randomMinutes);
      _flaggedTimes[_flaggedTimes.indexOf(time)] = time.add(randomDuration);
    });
    print(_flaggedTimes);
  }

  Duration _getDuration(String timeZone) {
    switch (timeZone) {
      case 'UTC+7:00 Jogja':
        return Duration(hours: 7);
      case 'UTC+9:00 Jayapura':
        return Duration(hours: 9);
      case 'UTC+0:00 London':
        return Duration(hours: 0);
      case 'UTC+8:00 Bali':
        return Duration(hours: 8);
      case 'UTC-5:00 New York':
        return Duration(hours: -5);
      default:
        return Duration(hours: 0); // Default to UTC
    }
  }

  double _convertCurrency(double harga) {
    switch (_selectedCurrency) {
      case 'Rupiah':
        return harga * 16000;
      case 'EUR':
        return harga * 0.92;
      default:
        return harga;
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

  String _calculateTotalPrice() {
    double total = 0;
    if (user != null) {
      for (int i = 0; i < user!.carts.length; i++) {
        total += _convertCurrency(user!.carts[i].price);
      }
    }
    return _formatPrice(total);
  }

  Future<void> removeFromCart(Products productData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? accIndex = prefs.getInt("accIndex");

    if (accIndex != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final User? currentUser = userBox.get(accIndex);

      if (currentUser != null) {
        // Find the index of the item to remove in the user's cart
        int indexToRemove = currentUser.carts.indexWhere((cartItem) =>
        cartItem.name == productData.title &&
            cartItem.price == productData.price!.toDouble());

        if (indexToRemove != -1) {
          // Remove the item from the cart if found
          currentUser.carts.removeAt(indexToRemove);
          userBox.put(accIndex, currentUser);

          print('Item removed from cart:');
          print('Name: ${productData.title}, Price: ${productData.price}');
        } else {
          print('Item not found in cart.');
        }
      }
    }
  }
}

