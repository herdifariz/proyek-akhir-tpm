import 'package:flutter/material.dart';

class ProfileEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.deepPurple, width: 2),
        minimumSize: Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Edit Profile',
        style: TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
