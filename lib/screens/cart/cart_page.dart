import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart.dart';
import '../../models/user.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadCart(); // Load the user's cart when the page is initialized
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

  void removeFromCart(Cart cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? accIndex = prefs.getInt("accIndex");

    if (accIndex != null && user != null) {
      final userBox = await Hive.openBox<User>('userBox');
      final User? currentUser = userBox.get(accIndex);

      if (currentUser != null) {
        currentUser.carts.removeWhere((item) =>
        item.name == cartItem.name && item.price == cartItem.price);

        userBox.put(accIndex, currentUser);
        setState(() {
          user = currentUser;
        });

        print('Item removed from cart:');
        print('Name: ${cartItem.name}, Price: ${cartItem.price}');
      }
    }
  }

  Widget _buildCartList() {
    if (user == null || user!.carts.isEmpty) {
      return Center(child: Text('No items in cart'));
    }

    return ListView.builder(
      itemCount: user!.carts.length,
      itemBuilder: (context, index) {
        final cartItem = user!.carts[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color of the product container to white
            borderRadius: BorderRadius.circular(12), // Make the corners rounded
          ),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin for spacing
          padding: EdgeInsets.all(8), // Add padding inside the container
          child: ListTile(
            title: Text(
              cartItem.name,
              style: TextStyle(
                color: Colors.deepPurple, // Set the text color to deep purple
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Price: ${cartItem.price}',
              style: TextStyle(
                color: Colors.deepPurple, // Set the text color to deep purple
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.deepPurple), // Set icon color to deep purple
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Remove from Cart", style: TextStyle(color: Colors.deepPurple)), // Set title color to deep purple
                      content: Text(
                        "Are you sure you want to remove this item from cart?",
                        style: TextStyle(color: Colors.deepPurple), // Set content color to deep purple
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            removeFromCart(cartItem);
                            Navigator.of(context).pop();
                          },
                          child: Text("Yes", style: TextStyle(color: Colors.deepPurple)), // Set button text color to deep purple
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No", style: TextStyle(color: Colors.deepPurple)), // Set button text color to deep purple
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      backgroundColor: Colors.deepPurple, // Set the background color to deep purple
      body: user != null ? _buildCartList() : Center(child: CircularProgressIndicator()),
    );
  }
}
