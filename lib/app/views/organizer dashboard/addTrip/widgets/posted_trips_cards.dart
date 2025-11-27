import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class PostedTripsCard extends StatelessWidget {
  const PostedTripsCard({super.key, required this.postedTrip});
  final TripModel postedTrip;
@override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  final String imageUrl =
      (postedTrip.images != null &&
              postedTrip.images!.isNotEmpty &&
              postedTrip.images!.last.isNotEmpty)
          ? postedTrip.images!.last
          : 'https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png';

  final String formattedTime =
      (postedTrip.startTime != null && postedTrip.startTime!.isNotEmpty)
          ? DateFormat("h:mm a").format(
              DateFormat('HH:mm:ss').parse(postedTrip.startTime!),
            )
          : '—';

  return Container(
    width: width,
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.kDisable,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      spacing: 8,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: width * 0.32, // 🔥 Responsive width (32% of screen)
                height: width * 0.24,
              ),
            ),
            const SizedBox(width: 12),

            // 🔥 يجعل النص يتمدد حسب المساحة المتاحة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          postedTrip.title,
                          style: AppFonts.kBoldFont.copyWith(
                            color: AppColors.kBlue,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildPopUpMenu(postedTrip.id ?? '', context),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.group, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          postedTrip.gatheringPlace ?? '',
                          style: AppFonts.kRegularFont.copyWith(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        formattedTime,
                        style: AppFonts.kRegularFont.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .format(postedTrip.startDate)
                            .toString(),
                        style: AppFonts.kRegularFont.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Flexible(
              child: Text(
                ' ${postedTrip.title}',
                style: AppFonts.kBoldFont.copyWith(
                  fontSize: 12,
                  color: AppColors.kOrange,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.swap_horiz, color: AppColors.kBlue),
            Flexible(
              child: Text(
                ' ${postedTrip.governorate}',
                style: AppFonts.kBoldFont.copyWith(
                  fontSize: 12,
                  color: AppColors.kOrange,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Row(
          children: [
            Icon(Icons.luggage, color: AppColors.kOrange, size: 32),
            const SizedBox(width: 8),
            Text(
              'Bookings: ${postedTrip.totalBookings}',
              style: AppFonts.kBoldFont.copyWith(
                fontSize: 18,
                color: AppColors.kBlue,
              ),
            ),
          ],
        ),
      ],
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
