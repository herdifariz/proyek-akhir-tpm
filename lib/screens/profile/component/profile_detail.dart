import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;

  ProfileDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          Text(value),
        ],
      ),
    );
  }
}
