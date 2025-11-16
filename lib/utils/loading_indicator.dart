import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

void showProgressIndicator(BuildContext context) {
  AlertDialog dialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 1,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.kOrange,
          size: 60,
        ),
        Text(
          'Loading...',
          textAlign:TextAlign.center,
          style: AppFonts.kBoldFont.copyWith(fontSize: 18,color: AppColors.kOrange),
        ),
      ],
    ),
  );

  showDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.4),
      barrierDismissible: false,
      builder: (context) {
        return dialog;
      });
}
