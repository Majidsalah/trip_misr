import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/controllers/addTrip%20cubit/add_trip_cubit.dart';
import 'package:trip_misr/app/controllers/all_trips_cubit/all_trips_cubit.dart';
import 'package:trip_misr/app/controllers/login%20cubit/login_cubit.dart';
import 'package:trip_misr/app/data/models/tripModel.dart';
import 'package:trip_misr/app/data/repositories/authRepo.dart';
import 'package:trip_misr/app/views/auth/welcom.dart';
import 'package:trip_misr/app/views/booked%20trips/my_trips.dart';
import 'package:trip_misr/app/views/organizer%20dashboard/addTrip/addTrip.dart';
import 'package:trip_misr/app/views/booking/customerBooking.dart';
import 'package:trip_misr/app/views/details/details.dart';
import 'package:trip_misr/app/views/home/home_screen.dart';
import 'package:trip_misr/app/views/auth/login.dart';
import 'package:trip_misr/app/views/splash/splashScreen.dart';
import 'package:trip_misr/utils/shared_pref.dart';
import 'package:trip_misr/utils/user_type.dart';

abstract class AppRouter {
  static String kSplashView = '/';
  static String kHomeView = '/homeScreen';
  static String kDetailes = '/detailes';
  static String kLoginScreen = '/login';
  static String kBookingScreen = '/booking';
  static String kAddTripScreen = '/addTrip';
  static String kMyTrips = '/myTrips';
  static String kWelcome = '/welcom';

  static final GoRouter router = GoRouter(
    initialLocation: kSplashView,
    routes: <RouteBase>[
      GoRoute(
        path: kSplashView,
        builder: (context, state) {
          return const Splashscreen();
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AllTripsCubit()..getAllTrips(),
            child: const Home(),
          );
        },
      ),
      GoRoute(
        path: kWelcome,
        builder: (context, state) {
          return BlocProvider(
              create: (context) => LoginCubit(), child: const Welcom());
        },
      ),
      GoRoute(
        path: kBookingScreen,
        builder: (context, state) {
          return const CustomerBooking();
        },
      ),
      GoRoute(
        path: kDetailes,
        builder: (context, state) {
          return  BlocProvider(
              create: (context) => AllTripsCubit(), child:  DetailsScreen(trip:state.extra as TripModel,));
        },
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: const LogIn(),
          );
        },
      ),
      GoRoute(
        path: kAddTripScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AddTripCubit(),
            child: const AddTripScreen(),
          );
        },
      ),
      GoRoute(
        path: kMyTrips,
        builder: (context, state) {
          return const MyTrips();
        },
      )
    ],
  );
}

Future<String> getInitialRoute() async {
  final userType = await ShPref.getUserType();

  if (userType == UserType.guest) {
    return AppRouter.kWelcome;
  }

  if (userType == UserType.normal || userType == UserType.oragnizer) {
    return Authrepo().userChecker() ? AppRouter.kHomeView : AppRouter.kWelcome;
  }

  return AppRouter.kWelcome; // fallback
}
