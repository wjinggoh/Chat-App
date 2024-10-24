import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/login_or_register.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo!
              DrawerHeader(
                
                child: Center(
                  child: Image.asset(
                    'assets/icons/ducky.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                
              ),

              //home icon
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              //settings icon
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ));
                  },
                ),
              ),
            ],
          ),

          //logout icon
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              leading: const Icon(Icons.logout, color: Colors.red),
              onTap: () {
                //pop the drawer
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOrRegister(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
