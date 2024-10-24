import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: 150,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 233, 177),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(children: [
          //icon
          Icon(Icons.person),

          //username
          Text(text),
        ]),
      ),
    );
  }
}
