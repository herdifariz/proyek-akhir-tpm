import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyek/screens/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class ProfileController {
  Future<void> updateProfile(
      String email,
      String name,
      String city,
      String address,
      String phone,
      BuildContext context
      ) async {
    try {
      final userBox = await Hive.openBox<User>('userBox');

      // Fetch the user by email
      final user = userBox.values.firstWhere(
            (user) => user.email == email,
        orElse: () => User('', '', '', '', '', '',[],[], ''),
      );

      if (user.email.isNotEmpty) {
        user.name = name;
        user.city = city;
        user.address = address;
        user.phone = phone;

        await user.save();

        print('Profile updated successfully.');

        Navigator.of(context).pop();
      } else {
        print('User with email $email not found.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> updateAvatar(String avatar, BuildContext context) async {
    try {
      final userBox = await Hive.openBox<User>('userBox');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? accIndex = prefs.getInt("accIndex");

      if (accIndex != null) {
        User? currentUser = userBox.getAt(accIndex);

        if (currentUser != null) {
          currentUser.avatar = avatar;
          await currentUser.save();
          print(currentUser.avatar);
          print('Profile updated successfully.');

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        } else {
          print('User not found.');
        }
      } else {
        print('Account index is null.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

}
