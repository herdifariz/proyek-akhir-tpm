import 'package:flutter/material.dart';

class ProductActions extends StatelessWidget {
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
