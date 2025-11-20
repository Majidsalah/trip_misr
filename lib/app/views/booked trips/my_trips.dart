import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_misr/app/controllers/booking_cubit/booking_cubit.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/my_trips_card.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/no_booked_trips.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
                    padding: const EdgeInsets.only(left: 16, top: 32),
                    child: Text(
                      'Booked Trips ✅',
                      style: AppFonts.kBoldFont
                          .copyWith(color: Colors.green, fontSize: 20),
                    ),
                  ),
          BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              if (state is TripsBookedByCustomerLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TripsBookedByCustomerSuccess) {
                if (state.bookedTrips.isEmpty) {
                  return Center(
                      child: NoBookedTripsWidget(
                    text: 'No Posted Trips',
                    onPressed: () async {
                      await context
                          .read<BookingCubit>()
                          .getBookedTripByCustomer();
                    },
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.bookedTrips.length,
                    itemBuilder: (context, index) => MyTripsCard(
                      trip: state.bookedTrips[0].tripModel!,
                    ),
                  ),
                );
              }
              return Column(
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
                  //  MyTripsCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ElevatedButton(
//               onPressed: ()async {
//                 final TripsRepo tripsRepo = TripsRepo();
//               await tripsRepo. getBookedTripByCustomer();
//               },
//               child: Text('click'))
