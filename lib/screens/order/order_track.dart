import 'package:flutter/material.dart';
import 'package:proyek/screens/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CLOCK/digital_clock.dart';

class OrderTrackingPage extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String fixedTime = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: _prefs,
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          String? _selectedTimeZone = snapshot.data!.getString('selectedTimeZone') ?? 'UTC';
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo
                    Icon(
                      Icons.terrain, // Replace this with your logo widget if available
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    // Order status text
                    Text(
                      'Your Order\nis On The Way',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Delivery icon
                    Icon(
                      Icons.delivery_dining,
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    // Progress bar
                    LinearProgressIndicator(
                      value: 0.7, // Replace with actual progress value
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    SizedBox(height: 20),
                    // Total price text
                    Text(
                      'Total : Total Price',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Estimated arrival time text
                    Text(
                      'Estimated arrive on:\nTime',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Back to Home button

                    DigitalClock(timeZone: _selectedTimeZone),
                    SizedBox(height: 30),
                    // Back to Settings button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
