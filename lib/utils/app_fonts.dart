import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_misr/utils/app_colors.dart';

class AppFonts {
  static TextStyle kBoldFont = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 41.39,
    color: AppColors.kBlue,
  
  );
   static TextStyle kRegularFont = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
  );
   static TextStyle kLightFont = GoogleFonts.montserrat(
    fontWeight: FontWeight.w300,
  );
}
