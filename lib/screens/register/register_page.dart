import 'package:flutter/material.dart';
import 'component/custom_text_field.dart';
import 'component/city_dropdown.dart';
import 'component/register_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedCity = 'Jogja'; // Nilai default
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Failed'),
          content: Text('Please check your input and try again.'),
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
      backgroundColor: Color(0xFF6200EE),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Icon(
                Icons.ac_unit,
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
                    CustomTextField(label: 'Name'),
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
                    CustomTextField(label: 'Address'),
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
                    SizedBox(height: 16),
                    CustomTextField(label: 'Password', obscureText: true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RegisterButton(
                validate: () {
                  return _validateEmail(emailController.text) &&
                      _validatePhone(phoneController.text);
                },
                onInvalid: _showErrorDialog,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
