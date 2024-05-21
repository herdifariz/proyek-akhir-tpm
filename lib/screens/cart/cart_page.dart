import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.deepPurple,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cart',
        style: TextStyle(
          color: Colors.deepPurple
        ),),
      ),
      body: FutureBuilder(
        future: Hive.openBox<Cart>('cartBox'), // Open the box
        builder: (BuildContext context, AsyncSnapshot<Box<Cart>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var box = snapshot.data;

            if (box == null || box.isEmpty) {
              return Center(child: Text('No items in cart'));
            }

            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final cartItem = box.getAt(index);
                return ListTile(
                  title: Text(cartItem!.name),
                  subtitle: Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Product Price',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          QuantityControl(),
        ],
      ),
    );
  }
}

class QuantityControl extends StatefulWidget {
  @override
  _QuantityControlState createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text(
          '$_quantity',
          style: TextStyle(fontSize: 18.0),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
