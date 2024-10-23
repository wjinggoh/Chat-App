import 'package:flutter/material.dart';
import 'package:minimal_chat_app/components/my_button.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';
import 'package:minimal_chat_app/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  RegisterPage({super.key});

//register method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register\n",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(225, 210, 147, 10),
                )),
            //logo
            // Using PNG as an icon
            Image.asset(
              'assets/icons/ducky.png',
              width: 80,
              height: 80,
            ),

            //welcome back message
            Text(
              '\n Welcome to ducky world!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontFamily: 'Arima',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            //email textfield
            MyTextField(
              hintText: "Email",
              obsecureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            //pw textfield
            MyTextField(
              //original no const, but the error msg says null type value, so i add the const var here
              hintText: "Password",
              obsecureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            //confirm pw textfield
            MyTextField(
              //original no const, but the error msg says null type value, so i add the const var here
              hintText: "Confirm Password",
              obsecureText: true,
              controller: _confirmPwController,
            ),

            const SizedBox(height: 25),
            //login button
            MyButton(
              text: "Register",
              onTap: register,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\n Already a🦆ducky member? "),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "\n Login Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black, // Optional: Makes it look like a link
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
