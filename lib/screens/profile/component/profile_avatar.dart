import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:proyek/controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';

class ProfileAvatar extends StatefulWidget {
  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _image;
  ProfileController profileController = ProfileController();
  late SharedPreferences logindata;
  User? currentUser;
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    openUserBox().then((_) => _loadAvatar());
  }

  Future<void> openUserBox() async {
    logindata = await SharedPreferences.getInstance();
    int? accIndex = logindata.getInt("accIndex");
    if (accIndex != null) {
      userBox = await Hive.openBox<User>('userBox');
      setState(() {
        currentUser = userBox.getAt(accIndex);
      });
    } else {
      print('Account index is null');
    }
  }

  Future<void> _loadAvatar() async {
    if (currentUser != null && currentUser!.avatar != null) {
      setState(() {
        _image = File(currentUser!.avatar!);
      });
    } else {
      print('Avatar path is null or user is null');
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileController.updateAvatar(pickedFile.path, context);
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundColor: Colors.grey,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: _image == null || _image!.path.isEmpty
                ? Icon(
              Icons.person,
              size: 100,
            )
                : ClipOval(
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
                width: 180,
                height: 180,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Colors.deepPurple,
                iconSize: 20,
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
