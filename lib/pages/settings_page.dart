import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() {
    //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the Row
          children: [
            Text(
              "Settings",
              style:
                  TextStyle(fontFamily: "Arima", fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16), // Add some space between the text and the icon
            Image.asset(
              'assets/icons/ducky.png', // Replace with your icon path
              height: 24, // Adjust height as needed
              width: 24, // Adjust width as needed
            ),
          ],
        ),
        backgroundColor: Colors.amber.shade200,

      ),
    );
  }
}
