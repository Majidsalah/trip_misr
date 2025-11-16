import 'package:flutter/material.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';     

class MyTripsCard extends StatelessWidget {
  const MyTripsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset('assets/28612.jpg',
                      fit: BoxFit.cover, width: 150, height: 120),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Taba',
                      style: AppFonts.kRegularFont
                          .copyWith(color: AppColors.kBlue, fontSize: 20),
                    ),
                  
                    Text(
                      '📍Sinai, Egypt',
                      style: AppFonts.kLightFont
                          .copyWith(color: AppColors.kLightBlue1, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.group),
                        Text(
                          ' Point: damietta',
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
                          ' Time: 6:00 am',
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
                  'Date: 3/8/2025',
                  style: AppFonts.kRegularFont.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 18),
                const Icon(Icons.hourglass_bottom),
                const SizedBox(width: 4),
                Text(
                  'Duration: 4/days',
                  style: AppFonts.kRegularFont.copyWith(
                    fontSize: 14,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
