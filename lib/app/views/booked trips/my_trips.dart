import 'package:flutter/material.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/my_trips_card.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ElevatedButton(
              onPressed: ()async {
                final TripsRepo tripsRepo = TripsRepo();
              await tripsRepo. getBookedTripByCustomer();
              },
              child: Text('click'))
        ],
      ),
    );
  }

}