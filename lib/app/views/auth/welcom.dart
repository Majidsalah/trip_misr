import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/controllers/login%20cubit/login_cubit.dart';
import 'package:trip_misr/component/social_icons.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_misr/utils/loading_indicator.dart';
import 'package:trip_misr/utils/shared_pref.dart';
import 'package:trip_misr/utils/snackBar.dart';
import 'package:trip_misr/utils/user_type.dart';

class Welcom extends StatelessWidget {
  const Welcom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: AppFonts.kBoldFont
                  .copyWith(fontSize: 24, color: AppColors.kOrange),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Sign In with google or continue guest \n or organizer',
              style: AppFonts.kLightFont
                  .copyWith(color: AppColors.kLightBlue1, fontSize: 15),
            ),
            const SizedBox(height: 50),
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state is LoginLoading) {
                  return showProgressIndicator(context);
                } else if (state is LoginSuccess) {
                  Navigator.pop(context);
                  mySnackBar(context, sucess: 'You are loggedIn successfully');
                  await ShPref.saveUserType(UserType.normal);
                  GoRouter.of(context).push(AppRouter.kHomeView);
                } else {
                  Navigator.pop(context);
                  mySnackBar(context, failed: 'ss');

                }
              },
              child: _buildLoginButtton('Login with google',
                  icon: const MyIcon(photo: 'assets/google.png'),
                  onTap: () async {
                await BlocProvider.of<LoginCubit>(context).userLogIn();
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildLoginButtton('Login as Guest', onTap: () async {
              await ShPref.saveUserType(UserType.guest);
              GoRouter.of(context).push(AppRouter.kHomeView);
            }),
            const SizedBox(
              height: 16,
            ),
            _buildLoginButtton('Login as Organizer', onTap: () {
              GoRouter.of(context).push(AppRouter.kLoginScreen);
            }),
          ],
        ),
      ),
    );
  }

  _buildLoginButtton(String text, {Widget? icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      highlightColor:AppColors.kOrange ,

      child: Container(
        width: 399.7,
        padding: const EdgeInsets.symmetric(vertical: 11),
        height: 65,
        
        decoration: BoxDecoration(
          
            borderRadius: const BorderRadius.all(Radius.circular(15.52)),
            border: Border.all(color: AppColors.kOrange)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox.shrink(),
            Center(
              child: Text(
                text,
                style: AppFonts.kRegularFont
                    .copyWith(color: AppColors.kOrange, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
