import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/controllers/login%20cubit/login_cubit.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:trip_misr/utils/loading_indicator.dart';
import 'package:trip_misr/utils/user_type.dart';

class UserAvatar extends StatelessWidget {
  final String? userName;
  final UserType currentUserType;

  UserAvatar(
      {super.key, required this.userName, required this.currentUserType});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LogOutLoading) {
          showProgressIndicator(context);
        } else if (state is LogOutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Logged out successfully"),
            ),
          );
          await GoRouter.of(context).pushReplacement(AppRouter.kWelcome);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Sorry Failed To Log Out !.. Please try again"),
            ),
          );
        }
      },
      child: PopupMenuButton<String>(
        onSelected: (value) async {
          await BlocProvider.of<LoginCubit>(context)
              .logout(currentUserType, context);
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'logout',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
        child: CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.kLightOrange,
            foregroundColor: AppColors.kBlue,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                "https://lh3.googleusercontent.com/a/ACg8ocIYqnQv3HFavFc07kKc9lDdPbTwszH1VoqM3QCHwgHRlWFB2ms=s96-c",
                fit: BoxFit.fitHeight,
              ),
            )),
      ),
    );
  }
}
// Text(
          
//             userName.isNotEmpty
//                 ? userName.substring(0, 2).toUpperCase()
//                 : "U", // أول حرفين من الاسم
//             style: TextStyle(color: AppColors.kLightBlue2, fontSize: 18),
//           ),