// import 'package:flutter/material.dart';
// import '../../login/login_page.dart';
//
// class RegisterButton extends StatelessWidget {
//   final bool Function() validate;
//   final void Function() onInvalid;
//
//   RegisterButton({required this.validate, required this.onInvalid});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         if (validate()) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//           );
//         } else {
//           onInvalid();
//         }
//       },
//       child: Text(
//         'Register',
//         style: TextStyle(color: Color(0xFF6200EE)),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         minimumSize: Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(color: Color(0xFF6200EE)),
//         ),
//       ),
//     );
//   }
// }
