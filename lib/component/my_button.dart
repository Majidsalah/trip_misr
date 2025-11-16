import 'package:flutter/material.dart';

class MyBoutton extends StatelessWidget {
  final Function()? onPressed;
  const MyBoutton({super.key,  this.onPressed, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          minimumSize: const Size(300, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
      onPressed: onPressed,
      child: Text(title) ,
    );
  }
}
