import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({super.key, required this.photo});

  final String photo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image.asset(
                photo,
                fit: BoxFit.cover,
                
              )),
        ),
      ),
    );
  }
}
