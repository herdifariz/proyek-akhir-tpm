import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundColor: Colors.grey,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Foto',
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.edit,
                color: Colors.deepPurple,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
