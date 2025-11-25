import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/widgets/trip_switer.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

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
          spacing: 8,
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
                        Text(
                          postedTrip.title,
                          style: AppFonts.kBoldFont.copyWith(
                            color: AppColors.kBlue,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 4),
                        _buildPopUpMenu(postedTrip.id ?? '', context),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      spacing: 6,
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
                      spacing: 6,
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
                      spacing: 6,
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
                Text(
                  ' ${postedTrip.title}',
                  style: AppFonts.kBoldFont
                      .copyWith(fontSize: 12, color: AppColors.kOrange),
                ),
                Icon(
                  Icons.swap_horiz,
                  color: AppColors.kBlue,
                ),
                Text(
                  ' ${postedTrip.governorate}',
                  style: AppFonts.kBoldFont
                      .copyWith(fontSize: 12, color: AppColors.kOrange),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.luggage,
                  color: AppColors.kOrange,
                  size: 32,
                ),
                Text(
                  'Bookings : ${postedTrip.totalBookings.toString()}',
                  style: AppFonts.kBoldFont.copyWith(
                    fontSize: 18,
                    color: AppColors.kBlue,
                  ),
                ),
                const SizedBox(width: 42),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopUpMenu(String id, BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      position: PopupMenuPosition.under,
      icon: const Icon(Icons.more_vert_outlined, size: 24, color: Colors.black),
      onSelected: (value) {
        if (value == "delete") {
          _showDeleteDialog(context, id);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "delete",
          child: Center(child: Text("Delete")),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Delete Trip ?"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  context.read<PostedTripsCubit>().deletePostedTripById(id);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
