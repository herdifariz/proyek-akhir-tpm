import 'package:flutter/material.dart';
import 'package:proyek/screens/home/home_page.dart';
import 'package:intl/intl.dart';

class OrderTrackingPage extends StatefulWidget {
  final List<DateTime> flaggedTime;
  final String totalHarga;

  OrderTrackingPage({required this.flaggedTime, required this.totalHarga});

  @override
  _OrderTrackingPageState createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // Gunakan this sebagai TickerProvider
      duration: Duration(seconds: 3),
    );

    // Start the animation to update the progress value from 0.0 to 1.0
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
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
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
              SizedBox(height: 20),
              // Total price text
              Text(
                'Total : ${widget.totalHarga}', // Display total price here
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              // Estimated arrival time text
              Text(
                'Estimated arrive on:\n${_formatFlaggedTime(widget.flaggedTime)}', // Display formatted flagged time here
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              // Back to Home button
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
  }

  String _formatFlaggedTime(List<DateTime> flaggedTime) {
    // Format flagged time to display only hours and minutes
    DateFormat dateFormat = DateFormat.Hm();
    String formattedTime = '';
    for (DateTime time in flaggedTime) {
      formattedTime += dateFormat.format(time) + '\n';
    }
    return formattedTime.trim(); // Trim any leading or trailing whitespace
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
