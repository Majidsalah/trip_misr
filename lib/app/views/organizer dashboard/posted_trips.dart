import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trip_misr/app/controllers/Usercubit/user_cubit.dart';
import 'package:trip_misr/app/controllers/all_trips_cubit/all_trips_cubit.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/no_booked_trips.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/widgets/posted_trips_cards.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';

class PostedTripsView extends StatelessWidget {
  const PostedTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostedTripsCubit, PostedTripsState>(
      listener: (context, state) {
        if (state is DeletingTripsSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Trip deleted successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is DeletingTripsFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cannot delete this trip"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<PostedTripsCubit>().getOrganizerPostedTrips();
          },
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().changeTab(0);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.kBlue,
                        size: 32,
                      )),
                  Text(
                    'Posted Trips',
                    style: AppFonts.kBoldFont
                        .copyWith(color: AppColors.kBlue, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<PostedTripsCubit, PostedTripsState>(
                  builder: (context, state) {
                    if (state is PostedTripLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PostedTripsSuccess) {
                      if (state.trips.isEmpty) {
                        return Center(
                            child: NoBookedTripsWidget(
                          text: 'No Posted Trips',
                          onPressed: () async {
                            await context
                                .read<PostedTripsCubit>()
                                .getOrganizerPostedTrips();
                          },
                        ));
                      }
                      return ListView.builder(
                        itemCount: state.trips.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kBookedCustomers,
                              extra: state.trips[index].id!,
                            );
                          },
                          child: PostedTripsCard(
                            postedTrip: state.trips[index],
                          ),
                        ),
                      );
                    } else if (state is PostedTripsFailed) {
                      return Center(
                          child: NoBookedTripsWidget(
                        text: 'There Was an Error \n Please Try again !!',
                        onPressed: () async {
                          await context
                              .read<PostedTripsCubit>()
                              .getOrganizerPostedTrips();
                        },
                      ));
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}























// import 'package:flutter/material.dart';
// import 'package:trip_misr/app/data/models/tripModel.dart';
// import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/widgets/posted_trips_card.dart';
// import 'package:trip_misr/utils/app_colors.dart';
// import 'package:trip_misr/utils/app_fonts.dart';
// import 'package:trip_misr/app/data/repositories/posted_trip_repo.dart';

// class PostedTripsView extends StatelessWidget {
//   const PostedTripsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               const SizedBox(height: 12),
//               Text(
//                 'Posted Trips',
//                 style: AppFonts.kBoldFont
//                     .copyWith(color: AppColors.kOrange, fontSize: 24),
//               ),
//               const SizedBox(height: 16),

//               // ✅ FutureBuilder to handle async data
//               Expanded(
//                 child: FutureBuilder<List<TripModel>>(
//                   future: PostedTripRepo().fetchPostedTrips(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text(
//                           'Error: ${snapshot.error}',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       );
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No trips posted yet.',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                       );
//                     }

//                     final trips = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: trips.length,
//                       itemBuilder: (context, index) {
//                         final trip = trips[index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           child: PostedTripsCard(postedTrip: trip),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

