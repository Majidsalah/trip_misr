import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_misr/app/controllers/booking_cubit/booking_cubit.dart';
import 'package:trip_misr/app/data/models/bookingModel.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/no_booked_trips.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/booked%20customers/bookedCustomerCards.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class BookedCustomers extends StatefulWidget {
  const BookedCustomers({super.key, required this.tripId});

  final String tripId;

  @override
  State<BookedCustomers> createState() => _BookedCustomersState();
}

class _BookedCustomersState extends State<BookedCustomers> {
  // @override
  // void initState() {
  //   super.initState();

  //   /// هنا نستدعي العملاء بناءً على tripId
  //  context.read<BookingCubit>().getBookedCustomersByTrip(widget.tripId);
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Booked Customers',
                style: AppFonts.kBoldFont
                    .copyWith(color: AppColors.kBlue, fontSize: 30),
              ),
            ),
            Expanded(child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                if (state is BookedCustomersLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BookedCustomersSuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return BookedCustomerCards(
                        bookingModel: state.bookedTrips[index],
                      );
                    },
                    itemCount: state.bookedTrips.length,
                  );
                } else if (state is BookedCustomersFailure) {
                  return Center(
                      child: NoBookedTripsWidget(
                    text: 'There No Booked Customers!!',
                    onPressed: () => Navigator.pop(context),
                  ));
                }
                return SizedBox.shrink();
              },
            ))
          ],
        ),
      ),
    ));
  }
}
