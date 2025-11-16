import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class NoBookedTripsWidget extends StatelessWidget {
  const NoBookedTripsWidget(
      {super.key, required this.text, this.onPressed, });
  final String text;
 final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_trips.png',
            height: 200,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            text,
            style: AppFonts.kBoldFont.copyWith(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Try Again',
              style: AppFonts.kBoldFont.copyWith(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
