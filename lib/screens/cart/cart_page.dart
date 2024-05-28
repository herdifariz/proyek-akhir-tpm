import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek/screens/order/order_track.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<DateTime> _flaggedTimes = [];
  String _selectedTimeZone = 'UTC+0:00 London';
  String _selectedCurrency = 'Rupiah';

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences when the page is initialized
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTimeZone = prefs.getString('selectedTimeZone') ?? 'UTC+0:00 London';
      _selectedCurrency = prefs.getString('selectedCurrency') ?? 'Rupiah';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            double total = 0;
            for (int i = 0; i < box.length; i++) {
              total += _convertCurrency(box.getAt(i)!.price);
            }


            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final cartItem = box.getAt(index);
                      return ListTile(
                        title: Text(cartItem!.name),
                        subtitle: Text(
                          'Price: ${_formatPrice(_convertCurrency(cartItem.price))}',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${_formatPrice(total)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _checkout(context, box, total); // Call checkout function and wait for the dialog to close
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _checkout(BuildContext context, Box<Cart> box, double total) async {
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
        content: Text('Total amount: ${_formatPrice(total)}'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderTrackingPage(
                    flaggedTime: _flaggedTimes,totalHarga: _formatPrice(total) // Pass the flagged time here
                  ),
                ),
              );
              box.clear();
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
}
