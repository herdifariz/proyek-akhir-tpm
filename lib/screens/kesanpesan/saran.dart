import 'package:flutter/material.dart';

class KesanPesanPage extends StatelessWidget {
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
          'Saran dan Kesan',
          style: TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Saran\n'
                        'Terkadang pertanyaan kuis cukup membingungkan sehingga sulit dipahami',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Kesan\n'
                        'Mata kuliah ini sangat menyenangkan karena saya cukup menyukai pemrogramana mobile',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple,
    );
  }
}
