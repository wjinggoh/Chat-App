import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_button.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chat_app/pages/home_page.dart'; // Import your homepage here

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // Function to handle user registration
  void register(BuildContext context) async {
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        // Try to sign up the user with email and password
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
          _confirmPwController.text,
        );

        // Navigate to the homepage on successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Replace with your actual HomePage widget
        );
      } on FirebaseAuthException catch (e) {
        // Handle specific FirebaseAuth exceptions
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
              e.code == 'email-already-in-use'
                  ? "The email address is already in use by another account."
                  : e.code == 'weak-password'
                      ? "The password provided is too weak."
                      : e.code == 'invalid-email'
                          ? "The email address is not valid."
                          : e.message ?? "An unknown error occurred.",
            ),
          ),
        );
      } catch (e) {
        // Catch other types of exceptions (non-FirebaseAuth exceptions)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      // Passwords do not match
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Passwords do not match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register\n",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 210, 147, 10),
                )),
            Image.asset(
              'assets/icons/ducky.png',
              width: 80,
              height: 80,
            ),
            const Text("\nQuack quack! nice to meet you!\n",
                style: TextStyle(
                    fontFamily: "Arima",
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const SizedBox(height: 20),
            MyTextField(
              hintText: "Email",
              obsecureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Password",
              obsecureText: true,
              controller: _pwController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Confirm Password",
              obsecureText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(height: 25),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("\nAlready a 🦆ducky member? "),
                GestureDetector(
                  onTap: onTap, // Toggle back to LoginPage
                  child: const Text(
                    "\nLogin Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
