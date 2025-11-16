import 'package:flutter/material.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/my_trips_card.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'My Trips',
            style:
                AppFonts.kBoldFont.copyWith(fontSize: 24, color: Colors.white),
          ),
          shadowColor: AppColors.kLightBlue2,
          elevation: 6,
          backgroundColor: AppColors.kOrange,
          centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32),
            child: Text(
              'Booked Trips ✅',
              style: AppFonts.kBoldFont
                  .copyWith(color: Colors.green, fontSize: 20),
            ),
          ),
          const MyTripsCard(),
        ],
      ),
    );
  }
}
