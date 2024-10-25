import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pages/chat_page.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_drawer.dart';
import 'package:minimal_chat_app/pages/settings_page.dart';
import 'package:minimal_chat_app/services/chat/chat_services.dart';

import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

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
            const Text(
              "Home",
              style:
                  TextStyle(fontFamily: "Arima", fontWeight: FontWeight.bold),
            ),
            const SizedBox(
                width: 16), // Add some space between the text and the icon
            Image.asset(
              'assets/icons/ducky.png', // Replace with your icon path
              height: 24, // Adjust height as needed
              width: 24, // Adjust width as needed
            ),
          ],
        ),
        backgroundColor: Colors.amber.shade100,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Navigate to SettingsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Navigate to SettingsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //build individual list title for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
