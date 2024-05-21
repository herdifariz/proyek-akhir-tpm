import 'package:flutter/material.dart';
import 'profile_avatar.dart';
import 'profile_detail.dart';
import 'profile_password_field.dart';
import 'profile_edit_button.dart';

class ProfileData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileAvatar(),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileDetail(title: 'Name', value: 'User Name'),
                  ProfileDetail(title: 'Email', value: 'Email User'),
                  ProfileDetail(title: 'City', value: 'User’s City'),
                  ProfileDetail(title: 'Address', value: 'User’s Address'),
                  ProfileDetail(title: 'Phone', value: 'User’s Phonenumber'),
                  ProfilePasswordField(),
                  SizedBox(height: 20),
                  ProfileEditButton(),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
