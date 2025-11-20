import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';

class SucessBooking extends StatelessWidget {
  const SucessBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done_rounded,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                'Trip Booked Successfully',
                style: AppFonts.kRegularFont
                    .copyWith(fontSize: 20.7, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kHomeView);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kOrange),
                child: Text(
                  'Go Home',
                  style: AppFonts.kRegularFont
                      .copyWith(color: Colors.white, fontSize: 20.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
