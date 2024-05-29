import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user.dart';
import 'profile_avatar.dart';
import 'profile_detail.dart';
import 'profile_password_field.dart';
import 'profile_edit_button.dart';

class ProfileData extends StatefulWidget {
  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  late Box<User> userBox;
  late SharedPreferences logindata;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    // Open the Hive box and fetch the current user data
    openUserBox();
  }

  Future<void> openUserBox() async {
    logindata = await SharedPreferences.getInstance();
    String? email = logindata.getString('email');
    userBox = await Hive.openBox<User>('userBox');
    setState(() {
      currentUser = userBox.values.firstWhere((user)=> user.email == email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Center(child: CircularProgressIndicator())
        : Container(
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
                  ProfileDetail(title: 'Name', value: currentUser!.name),
                  ProfileDetail(title: 'Email', value: currentUser!.email),
                  ProfileDetail(title: 'City', value: currentUser!.city),
                  ProfileDetail(title: 'Address', value: currentUser!.address),
                  ProfileDetail(title: 'Phone', value: currentUser!.phone),
                  ProfilePasswordField(password: currentUser!.password),
                  SizedBox(height: 20),
                  ProfileEditButton(userEmail: currentUser!.email),
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
