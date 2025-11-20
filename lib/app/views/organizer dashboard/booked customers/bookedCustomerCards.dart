import 'package:flutter/material.dart';
import 'package:trip_misr/app/data/models/bookingModel.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';

class BookedCustomerCards extends StatelessWidget {
  const BookedCustomerCards({
    super.key,
    required this.bookingModel,
  });
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kDisable,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 8,
            children: [
              Column(
                spacing: 10,
                children: [
                  const Icon(
                    Icons.person,
                  ),
                  const Icon(
                    Icons.phone,
                  ),
                  const Icon(
                    Icons.child_care,
                  ),
                  const Icon(
                    Icons.group,
                  ),
                  const Icon(
                    Icons.pending_actions,
                  ),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text(
                    'Name :${bookingModel.customerName}',
                    style: AppFonts.kLightFont.copyWith(
                        color: AppColors.kLightBlue1,
                        fontSize: 18.7,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Phone :${bookingModel.customerPhone}',
                    style: AppFonts.kLightFont.copyWith(
                        color: AppColors.kLightBlue1,
                        fontSize: 18.7,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Child :${bookingModel.children}',
                    style: AppFonts.kLightFont.copyWith(
                        color: AppColors.kLightBlue1,
                        fontSize: 18.7,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Adult :${bookingModel.adults}',
                    style: AppFonts.kLightFont.copyWith(
                        color: AppColors.kLightBlue1,
                        fontSize: 18.7,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'status :${bookingModel.status}',
                    style: AppFonts.kLightFont.copyWith(
                        color: AppColors.kLightBlue1,
                        fontSize: 18.7,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
