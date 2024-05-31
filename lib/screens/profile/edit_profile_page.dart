import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user.dart';
import '../register/component/city_dropdown.dart';
import '../register/component/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String selectedCity = 'Jogja';
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final ProfileController profileController = ProfileController();
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
    // String? email = logindata.getString('email');
    int? accIndex = logindata.getInt("accIndex");
    userBox = await Hive.openBox<User>('userBox');
    setState(() {
      // currentUser = userBox.values.firstWhere((user)=> user.email == email);
      currentUser = userBox.getAt(accIndex!);
    });

    emailController.text = currentUser!.email;
    nameController.text = currentUser!.name;
    selectedCity = currentUser!.city;
    addressController.text = currentUser!.address;
    phoneController.text = currentUser!.phone;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _validateEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    String phonePattern = r'^[0-9]+$';
    RegExp regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF6200EE),
      ),
      backgroundColor: Color(0xFF6200EE),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        label: 'Name',
                        controller: nameController,
                      ),
                      SizedBox(height: 16),
                      CityDropdown(
                        selectedCity: selectedCity,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCity = newValue!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Address',
                        controller: addressController,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Phone',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_validateEmail(emailController.text) &&
                        _validatePhone(phoneController.text)) {
                      profileController.updateProfile(
                        emailController.text,
                        nameController.text,
                        selectedCity,
                        addressController.text,
                        phoneController.text,
                        context,
                      );
                    } else {
                      _showErrorDialog('Please check your input and try again.');
                    }
                  },
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Color(0xFF6200EE)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
