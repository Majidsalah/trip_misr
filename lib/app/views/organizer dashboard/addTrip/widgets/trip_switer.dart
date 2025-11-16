import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

// ignore: must_be_immutable
class TripSwitcher extends StatefulWidget {
  TripSwitcher({super.key});

  @override
  State<TripSwitcher> createState() => _TripSwitcherState();
  bool isActive = false;
}

class _TripSwitcherState extends State<TripSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.isActive ? '🟢 Active' : 'Off',
          style: AppFonts.kRegularFont.copyWith(
            fontSize: 14,
          ),
        ),
        Transform.scale(
          scale: 0.75,
          child: Switch(
            value: widget.isActive,
            onChanged: (value) {
              setState(() {
                widget.isActive = !widget.isActive;
              });
            },
            activeColor: AppColors.kOrange,
          ),
        )
      ],
    );
  }
}
