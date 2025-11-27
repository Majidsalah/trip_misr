import 'package:flutter/material.dart';

void mySnackBar(BuildContext context,{ String? sucess, String? failed}) {
  final ScaffoldMessengerState scaffoldMessenger =
      ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(sucess == null
      ? SnackBar(
          content: Text(failed!),
          backgroundColor: Colors.red,
        )
      : SnackBar(
          content: Text(sucess),
          backgroundColor: Colors.green,
        ));
}
