import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pages/login_page.dart';
import 'package:minimal_chat_app/pages/register_page.dart';

// Import your lightMode theme
import 'package:minimal_chat_app/themes/light_mode.dart'; // Assuming your theme is in this file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode, // Apply your theme here
      home: LoginPage(), // 'const' only for stateless widgets like LoginPage
    );
  }
}

/*2 methods can be used,
1st one i didnt used which is initiate a login_or_register, main initialise to login
2nd i used personally, main.dart: home=login page
then how to interact the text button of register/login now?
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
I used gesture detector to detect the behavior
*/
