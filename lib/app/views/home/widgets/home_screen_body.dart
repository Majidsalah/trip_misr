import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trip_misr/app/controllers/all_trips_cubit/all_trips_cubit.dart';
import 'package:trip_misr/app/controllers/login%20cubit/login_cubit.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/views/booked%20trips/widgets/no_booked_trips.dart';
import 'package:trip_misr/app/views/home/widgets/place_card_list.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:trip_misr/app/views/home/widgets/user_avatar.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:trip_misr/utils/shared_pref.dart';
import 'package:trip_misr/utils/user_type.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          await context.read<AllTripsCubit>().getAllTrips();
        },
        child: BlocBuilder<AllTripsCubit, AllTripsState>(
          builder: (context, state) {
            final bool isLoading = state is AllTripsLoading;
            final bool isSuccess = state is AllTripsSuccess;
            final bool isFailed = state is AllTripsFailed;
            final bool isFilteredEmpty = state is FilteredTripsFailed;

            // 🟥 حالة الخطأ
            if (isFailed) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: NoBookedTripsWidget(
                    text: 'There was an error.\nPlease try again!',
                    onPressed: () async =>
                        await context.read<AllTripsCubit>().getAllTrips(),
                  ),
                ),
              );
            }

            // 🟩 حالة النجاح أو التحميل
            final images = isSuccess
                ? context.read<AllTripsCubit>().getAllTripsImages(state.trips)
                : <String>[
                    'https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png'
                  ];

            return Skeletonizer(
              enabled: isLoading,
              effect: ShimmerEffect(
                baseColor: AppColors.kDisable,
                highlightColor: AppColors.kLightOrange.withOpacity(0.5),
                duration: const Duration(seconds: 1),
              ),
              child: BlocProvider(
                create: (context) => PostedTripsCubit(),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: _buildCustomAppBar(context)),
                    SliverToBoxAdapter(child: const SizedBox(height: 16)),
                    SliverToBoxAdapter(child: _buildWelcomeText()),
                    SliverToBoxAdapter(child: const SizedBox(height: 8)),
                    SliverToBoxAdapter(
                        child: _buidSearchBar(
                            context, fromController, toController)),
                    SliverToBoxAdapter(child: _buildCardSwiper(images)),
                    SliverToBoxAdapter(
                      child: Divider(
                        color: AppColors.kLightOrange,
                        endIndent: 30,
                        indent: 24,
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 12)),
                    if (isFilteredEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: const Center(
                          child: NoBookedTripsWidget(
                            text: 'No Trips Found',
                          ),
                        ),
                      ),
                    if (isSuccess)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return PlaceCardList(
                              trip: state.trips[index],
                              images: state.trips[index].images ?? [],
                            );
                          },
                          childCount: state.trips.length,
                        ),
                      ),
                    // SliverToBoxAdapter(
                    //   child: Image.asset(
                    //     'assets/logo.PNG',
                    //     height: 40,
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buidSearchBar(
  BuildContext context,
  TextEditingController fromController,
  TextEditingController toController,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.kOrange, width: 1.5)),
        child: TextField(
          controller: fromController,
          onChanged: (_) {
            context.read<AllTripsCubit>().searchTrips(
                  fromController.text,
                  toController.text,
                );
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'From',
              hintStyle: AppFonts.kRegularFont.copyWith(fontSize: 12),
              prefixIcon: const Icon(Icons.person_pin_circle_outlined),
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
      const Icon(Icons.swap_horiz),
      Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.kOrange, width: 1.5)),
        child: TextField(
          controller: toController,
          onChanged: (_) {
            context.read<AllTripsCubit>().searchTrips(
                  fromController.text,
                  toController.text,
                );
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: 'To',
              hintStyle: AppFonts.kRegularFont.copyWith(fontSize: 12),
              prefixIcon: const Icon(Icons.card_travel),
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    ],
  );
}

Widget _buildCustomAppBar(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/Asset 2@2x.png',
          height: 40,
        ),
        currentUserType() == UserType.guest
            ? TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kWelcome);
                },
                style: TextButton.styleFrom(backgroundColor: AppColors.kOrange),
                child: Text(
                  'Login',
                  style: AppFonts.kBoldFont
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              )
            : BlocProvider(
                create: (context) => LoginCubit(),
                child: UserAvatar(
                  avatarUrl: ShPref.getUserAvatar(),
                  currentUserType: currentUserType(),
                ),
              ),
      ],
    ),
  );
}

Widget _buildWelcomeText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Where do you wanna go?',
        style: AppFonts.kBoldFont.copyWith(fontSize: 24),
      ),
    ],
  );
}

Widget _buildCardSwiper(List images) {
  return SizedBox(
    height: 250,
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            images[index],
            fit: BoxFit.fitWidth,
          ),
        );
      },
      itemCount: images.length,
      itemWidth: 433.34,
      itemHeight: 200,
      layout: SwiperLayout.TINDER,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
            color: AppColors.kDisable, activeColor: AppColors.kOrange, size: 7),
        alignment: const Alignment(0, 1.05),
      ),
    ),
  );
}
