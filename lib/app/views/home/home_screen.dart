import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/controllers/Usercubit/user_cubit.dart';
import 'package:trip_misr/app/controllers/booking_cubit/booking_cubit.dart';
import 'package:trip_misr/app/controllers/postedTrip%20cubit/posted_trips_cubit.dart';
import 'package:trip_misr/app/views/booked%20trips/my_trips.dart';
import 'package:trip_misr/app/views/home/widgets/home_screen_body.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/posted_trips.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:trip_misr/utils/user_type.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final userType = currentUserType(); // جاي من shared_pref عندك

    return BlocProvider(
      create: (_) => HomeCubit(userType),
      child: BlocBuilder<HomeCubit, UserState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          // الشاشات حسب نوع اليوزر
          final screens = _getScreens(state.userType);
          final navItems = _getNavItems(state.userType);

          return SafeArea(
            child: Scaffold(
              floatingActionButton: state.userType == UserType.oragnizer
                  ? FloatingActionButton(
                      onPressed: () async {
                        // final user = Supabase.instance.client.auth.currentUser;
                        // log('${user!.id}: HOOOOme');
                        GoRouter.of(context).push(AppRouter.kAddTripScreen);
                      },
                      backgroundColor: AppColors.kOrange.withOpacity(0.8),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    )
                  : null,
              bottomNavigationBar: state.userType != UserType.guest
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 60, right: 60, top: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: NavigationBar(
                          height: 50,
                          backgroundColor: AppColors.kOrange,
                          selectedIndex: state.currentIndex,
                          onDestinationSelected: cubit.changeTab,
                          labelBehavior: NavigationDestinationLabelBehavior
                              .onlyShowSelected,
                          indicatorColor: Colors.transparent,
                          destinations: navItems,
                        ),
                      ),
                    )
                  : null,
              body: IndexedStack(
                index: state.currentIndex < screens.length
                    ? state.currentIndex
                    : 0, // safe guard
                children: screens,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _getScreens(UserType type) {
    switch (type) {
      case UserType.oragnizer:
        return [
           HomeScreenBody(),
          BlocProvider(
            create: (context) => PostedTripsCubit()..getOrganizerPostedTrips(),
            child: PostedTripsView(),
          ), // شاشة Trips للمنظم
        ];
      case UserType.normal:
        return  [
          HomeScreenBody(),
          BlocProvider(
            create: (context) => BookingCubit()..getBookedTripByCustomer(),
            child: MyTrips(),
          ), // شاشة Trips لليوزر العادي
        ];
      case UserType.guest:
        return [
          HomeScreenBody(), // بس الـ Explore
        ];
    }
  }

  List<NavigationDestination> _getNavItems(UserType type) {
    switch (type) {
      case UserType.oragnizer:
        return [
          NavigationDestination(
            icon: Icon(Icons.explore, color: AppColors.kBlue, size: 30),
            selectedIcon: const Icon(Icons.explore, color: Colors.white),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.route, color: AppColors.kBlue, size: 30),
            selectedIcon: const Icon(Icons.route, color: Colors.white),
            label: 'My Trips',
          ),
        ];
      case UserType.normal:
        return [
          NavigationDestination(
            icon: Icon(Icons.explore, color: AppColors.kBlue, size: 30),
            selectedIcon: const Icon(Icons.explore, color: Colors.white),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.flight, color: AppColors.kBlue, size: 30),
            selectedIcon: const Icon(Icons.route, color: Colors.white),
            label: 'My Trips',
          ),
        ];
      case UserType.guest:
        return const [];
    }
  }
}
