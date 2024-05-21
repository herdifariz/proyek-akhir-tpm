import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 60.0, // Memperbesar ukuran lingkaran
          backgroundColor: Colors.white,
          child: Text("Foto", style: TextStyle(fontSize: 24.0)),
        ),
        SizedBox(width: 20.0), // Jarak antara foto dan teks
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name", style: TextStyle(color: Colors.white, fontSize: 20.0)), // Ganti dengan nama pengguna
            SizedBox(height: 8.0),
            Text("Phone", style: TextStyle(color: Colors.white)), // Ganti dengan nomor telepon
            SizedBox(height: 4.0),
            Text("Email", style: TextStyle(color: Colors.white)), // Ganti dengan alamat email
          ],
        ),
      ],
    );
  }
}
