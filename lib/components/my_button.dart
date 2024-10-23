import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 205, 26),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Arima',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
