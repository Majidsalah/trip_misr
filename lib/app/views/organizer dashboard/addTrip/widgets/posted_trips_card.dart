import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/trips_repo.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/widgets/trip_switer.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/loading_indicator.dart';
import 'package:trip_misr/utils/snackBar.dart';

class PostedTripsCard extends StatelessWidget {
  const PostedTripsCard({super.key, required this.postedTrip});
  final TripModel postedTrip;
  @override
  Widget build(BuildContext context) {
    // ✅ Safe image source
    final String imageUrl = (postedTrip.images != null &&
            postedTrip.images!.isNotEmpty &&
            postedTrip.images!.last.isNotEmpty)
        ? postedTrip.images!.last
        : 'https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png'; // fallback image

    // ✅ Safe formatted time
    final String formattedTime =
        (postedTrip.startTime != null && postedTrip.startTime!.isNotEmpty)
            ? DateFormat("h:mm a").format(
                DateFormat('HH:mm:ss').parse(postedTrip.startTime!),
              )
            : '—';
    return Container(
      height: 250,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kDisable,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(imageUrl,
                      fit: BoxFit.cover, width: 150, height: 120),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان بياخد المساحة اللي محتاجها فقط
                        Text(
                          postedTrip.title,
                          style: AppFonts.kRegularFont.copyWith(
                            color: AppColors.kBlue,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 4),
                        _buildPopUpMenu(postedTrip.id ?? '', context),
                      ],
                    ),
                    Text(
                      postedTrip.title,
                      style: AppFonts.kLightFont
                          .copyWith(color: AppColors.kLightBlue1, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.group),
                        Text(
                          postedTrip.gatheringPlace ?? '',
                          style: AppFonts.kRegularFont.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        Text(
                          formattedTime,
                          style: AppFonts.kRegularFont.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .format(postedTrip.startDate)
                              .toString(),
                          style: AppFonts.kRegularFont.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.luggage),
                Text(
                  ' Bookings: 20',
                  style: AppFonts.kRegularFont.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 42),
                TripSwitcher()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopUpMenu(String id, context) {
    return PopupMenuButton(
        // constraints: const BoxConstraints(
        //   maxWidth: 150,
        // ),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        position: PopupMenuPosition.under,
        icon:
            const Icon(Icons.more_vert_outlined, size: 24, color: Colors.black),
        itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  // context that has PostedTripsCubit

                  showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          actions: [
                            BlocProvider(
                              create: (BuildContext context) =>
                                  PostedTripsCubit(),
                              child: BlocBuilder<PostedTripsCubit,
                                  PostedTripsState>(
                                builder: (context, state) {
                                  if (state is DeletingTripsSucces) {
                                    mySnackBar(context,
                                        sucess: 'Trip deleted Successfully ');
                                    return Center(
                                        child: Text(
                                      "Trip deleted Successfully",
                                    ));
                                  } else if (state is DeletingTripsFailed) {
                                    mySnackBar(context,
                                        failed: 'Cant delete this Trip !!');
                                    return Center(
                                        child: Text(
                                      "Cant delete this Trip !!",
                                    ));
                                  } else if (state is DeletingTripsLoading) {
                                    showProgressIndicator(context);
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                    PostedTripsCubit>(context)
                                                .deletePostedTripById(id);
                                          },
                                          child: Center(
                                              child: Text('delete',
                                                  style: const TextStyle(
                                                      color: Colors.red)))),
                                      const Spacer(flex: 1),
                                      TextButton(
                                        onPressed: () {},
                                        child: Center(
                                          child: Text(
                                            "cancel",
                                            style: const TextStyle(
                                                color: Colors.green),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      });
                },
                child: const Center(
                    child: Text(
                  'Delete',
                )),
              ),
            ]);
  }
}
