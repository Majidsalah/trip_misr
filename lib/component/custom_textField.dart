import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String lab;
  final String? hint;
  final Icon? icon;
  final bool? isPassword;
  final int? height;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? eye;
  final TextInputType? keyboardType;
  final Function(String)? submitt;
  const CustomTextField(
      {super.key,
      this.hint,
      this.icon,
      required this.lab,
      this.isPassword,
      this.controller,
      this.validator,
      this.eye,
      this.submitt,
      this.keyboardType,
      this.height});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: isPassword == null ? height : 1,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
          suffixIcon: eye,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ),
          prefix: icon,
          hintText: hint,
          focusColor: AppColors.kOrange,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.kOrange, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelStyle: TextStyle(color: AppColors.kOrange),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(lab),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
