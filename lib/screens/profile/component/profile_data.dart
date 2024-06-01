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
    openUserBox();
  }

  Future<void> openUserBox() async {
    logindata = await SharedPreferences.getInstance();
    int? accIndex = logindata.getInt("accIndex");
    userBox = await Hive.openBox<User>('userBox');
    setState(() {
      currentUser = userBox.getAt(accIndex!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Center(child: CircularProgressIndicator())
        : Container(
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Spacer(),
            ProfileAvatar(),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  ProfileDetail(title: 'Name            ', value: currentUser!.name),
                  ProfileDetail(title: 'Email             ', value: currentUser!.email),
                  ProfileDetail(title: 'City                ', value: currentUser!.city),
                  ProfileDetail(title: 'Address        ', value: currentUser!.address),
                  ProfileDetail(title: 'Phone           ', value: currentUser!.phone),
                  SizedBox(height: 20),
                  ProfileEditButton(userEmail: currentUser!.email),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
