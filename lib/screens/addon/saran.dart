import 'package:flutter/material.dart';

class PesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pesan Kesan',
          style: TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Text(
            'kesan saya selama belajar pemrograman ini adalah lorem 50 jndjia wbjdwa',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple,
    );
  }
}
