import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileAvatar extends StatefulWidget {
  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _image;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
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
            child: _image == null
                ? Text(
              'Foto',
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
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
