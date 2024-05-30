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
      BuildContext context // Tambahkan BuildContext untuk navigasi
      ) async {
    try {
      final userBox = await Hive.openBox<User>('userBox');

      // Fetch the user by email
      final user = userBox.values.firstWhere(
            (user) => user.email == email,
        orElse: () => User('', '', '', '', '', '',[],[]),
      );

      if (user.email.isNotEmpty) {
        // Update user details
        user.name = name;
        user.city = city;
        user.address = address;
        user.phone = phone;

        // Save the updated user back to the Hive box
        await user.save();

        print('Profile updated successfully.');

        // Navigate back to the profile page after successful update
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(), // Sertakan data user jika diperlukan
          ),
        );
      } else {
        print('User with email $email not found.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> updateAvatar (String avatar, BuildContext context) async {
    try {
      final userBox = await Hive.openBox<User>('userBox');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? accIndex = prefs.getInt("accIndex");

      if (accIndex != null) {
        User? currentUser = userBox.get(accIndex);
        if (currentUser != null) {
          currentUser.avatar = avatar;
          await currentUser.save();
          print(currentUser.avatar);
          print('Profile updated successfully.');
        }

        // Navigate back to the profile page after successful update
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfileScreen(), // Sertakan data user jika diperlukan
          ),
        );
      } else {
        print('User not found.');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
