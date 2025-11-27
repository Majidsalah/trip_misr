import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';

class PlaceCardList extends StatelessWidget {
  final TripModel trip;
  final List<String> images;

  const PlaceCardList({
    super.key,
    required this.trip,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    // if (trip.images!.isEmpty) {
    //   return Center(
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(vertical: 50),
    //       child: Column(
    //         spacing: 20,
    //         children: [
    //           SizedBox(
    //             height:height*0.1,
    //             child: Image.network(
    //               'https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png',
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           Text("No available trips right now",
    //               style: AppFonts.kBoldFont.copyWith(fontSize: 16)),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    return InkWell(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kDetailes, extra: trip);
        },
        child: _buildTripCard(context, trip, images));
  }

  Widget _buildTripCard(
      BuildContext context, TripModel trip, List<String> tripImages) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 220, // 🔒 حجم الكارد ثابت
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: tripImages.isNotEmpty
                ? SizedBox(
                    height: height * 0.15,
                    width: double.infinity,
                    child: Swiper(
                      itemBuilder: (context, index) {
                        return Image.network(
                          tripImages[index],
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: tripImages.length,
                      pagination: const SwiperPagination(),
                    ),
                  )
                : SizedBox(
                    height: height * 0.15,
                    width: double.infinity,
                    child: Image.network(
                      'https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        trip.title,
                        style: AppFonts.kBoldFont.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            ' ${trip.title}',
                            style: AppFonts.kBoldFont.copyWith(
                                fontSize: 12, color: AppColors.kOrange),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.swap_horiz,
                            color: AppColors.kBlue,
                          ),
                          Text(
                            ' ${trip.title}',
                            style: AppFonts.kBoldFont.copyWith(
                                fontSize: 12, color: AppColors.kOrange),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // السعر
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${trip.price} LE",
                        style: AppFonts.kBoldFont.copyWith(
                          fontSize: 16,
                          color: AppColors.kOrange,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (trip.hotelRating ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
