import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class MyTripsCard extends StatelessWidget {
  const MyTripsCard({super.key, required this.trip});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final String formattedTime =
        (trip.startTime != null && trip.startTime!.isNotEmpty)
            ? DateFormat("h:mm a").format(
                DateFormat('HH:mm:ss').parse(trip.startTime!),
              )
            : '—';
    return Container(
      height: 200,
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
                  child: Image.network(trip.images!.first,
                      fit: BoxFit.cover, width: 150, height: 120),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppFonts.kRegularFont
                          .copyWith(color: AppColors.kBlue, fontSize: 20),
                    ),
                    Text(
                      '📍${trip.governorate}, Egypt',
                      style: AppFonts.kLightFont
                          .copyWith(color: AppColors.kLightBlue1, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.group),
                        Text(
                          ' Point: ${trip.gatheringPlace}',
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
                          ' Time: $formattedTime',
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
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 4),
                Text(
                  'Date:${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()}',
                  style: AppFonts.kRegularFont.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 18),
                // const Icon(Icons.hourglass_bottom),
                // const SizedBox(width: 4),
                // Text(
                //   'Duration: 4/days',
                //   style: AppFonts.kRegularFont.copyWith(
                //     fontSize: 14,
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
