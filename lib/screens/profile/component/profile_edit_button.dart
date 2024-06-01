import 'package:flutter/material.dart';
import 'package:proyek/screens/profile/edit_profile_page.dart';

class ProfileEditButton extends StatelessWidget {
  final String userEmail;

  ProfileEditButton({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.deepPurple, width: 2),
          minimumSize: Size(200, 50),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
    );
  }
}
