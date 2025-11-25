// import 'package:trip_misr/app/data/models/tripModel.dart';
// import 'package:trip_misr/utils/app_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:trip_misr/utils/app_colors.dart';
// import 'package:trip_misr/utils/app_router.dart';

// class PlaceCardList extends StatelessWidget {
//  const PlaceCardList({super.key, required this.images, required this.trips});

//   final List<TripModel> trips;
//   final List<dynamic> images;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 230,
//       width: 500,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: trips.length,
//           shrinkWrap: true,
//           itemBuilder: (_, i) {
//             final imageUrl = (i < images.length && images[i] != null)
//                 ? images[i].toString()
//                 : 'https://via.placeholder.com/200x150?text=No+Image';

//             return InkWell(
//               onTap: () => GoRouter.of(context).push(AppRouter.kDetailes),
//               child: Container(
//                 height: 150,
//                 width: 250,
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(right: 12),
//                 decoration: BoxDecoration(
//                     color: const Color(0xffEDEEEF),
//                     borderRadius: BorderRadius.circular(20.7)),
//                 child: Column(
//                   children: [
//                     Stack(alignment: Alignment.topRight, children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(13),
//                         child: Image.network(
//                           imageUrl,
//                           width: double.infinity,
//                           height: 140,
//                           fit: BoxFit
//                               .cover, // 🔹 الصورة تملى المساحة وتتحكم في نسبتها
//                           errorBuilder: (context, error, stackTrace) =>
//                               Container(
//                             color: Colors.grey.shade300,
//                             alignment: Alignment.center,
//                             child: const Icon(Icons.broken_image,
//                                 size: 40, color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 30,
//                         width: 30,
//                         margin: const EdgeInsets.only(right: 6, top: 6),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColors.kDisable.withOpacity(0.3),
//                           shape: BoxShape.circle,
//                         ),
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {},
//                           icon: const Icon(Icons.favorite_border),
//                           color: Colors.white,
//                           iconSize: 24,
//                         ),
//                       ),
//                     ]),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               trips[i].title,
//                               style: AppFonts.kRegularFont.copyWith(
//                                   color: AppColors.kBlue, fontSize: 20),
//                             ),
//                             Text(
//                               trips[i].gatheringPlace ?? '',
//                               style: AppFonts.kLightFont.copyWith(
//                                   color: AppColors.kLightBlue1, fontSize: 15),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               size: 19,
//                               color: AppColors.kOrange,
//                             ),
//                             Text(
//                               '4.8',
//                               style: AppFonts.kLightFont.copyWith(
//                                   fontSize: 18, color: AppColors.kLightBlue2),
//                             )
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';

class PlaceCardList extends StatelessWidget {
  final List<TripModel> trips;
  final List<dynamic> images; // optional general images list (for fallback)

  const PlaceCardList({
    super.key,
    required this.trips,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(
                height: 140,
                child: Image.asset(
                  'assets/no_trips.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text("No available trips right now",
                  style: AppFonts.kBoldFont.copyWith(fontSize: 16)),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        final tripImages = trip.images ?? [];

        return InkWell(
            onTap: () {
              GoRouter.of(context)
                  .push(AppRouter.kDetailes, extra: trips[index]);
            },
            child: _buildTripCard(context, trip, tripImages));
      },
    );
  }

  Widget _buildTripCard(
      BuildContext context, TripModel trip, List<String> tripImages) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 220, // 🔒 حجم الكارد ثابت
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🖼️ صور الرحلة (Swiper أو صورة واحدة)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: tripImages.isNotEmpty
                ? SizedBox(
                    height: 140,
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
                    height: 140,
                    child: Image.asset(
                      'assets/no_trips.png',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),

          // 📋 تفاصيل الرحلة
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الاسم والموقع
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        trip.title,
                        style: AppFonts.kBoldFont.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            ' ${trip.governorate}',
                            style: AppFonts.kBoldFont.copyWith(
                                fontSize: 12, color: AppColors.kOrange),
                          ),
                          Icon(
                            Icons.swap_horiz,
                            color: AppColors.kBlue,
                          ),
                          Text(
                            ' ${trip.title}',
                            style: AppFonts.kBoldFont
                                .copyWith(fontSize: 12,color:  AppColors.kOrange),
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
