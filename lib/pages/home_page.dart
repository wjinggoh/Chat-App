import 'package:flutter/material.dart';
import 'package:minimal_chat_app/auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_drawer.dart';
import 'package:minimal_chat_app/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout(BuildContext context) {
    // Get auth service and log out
    final _auth = AuthService();
    _auth.signOut().then((_) {
      // Optionally, navigate back to the login page or show a message
      Navigator.of(context)
          .pushReplacementNamed('/login'); // Change this route as necessary
    }).catchError((error) {
      // Handle any errors during logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging out: $error")),
      );
    });
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
              "Home",
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
        backgroundColor: Colors.amber.shade100,
      ),
      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Navigate to SettingsPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
