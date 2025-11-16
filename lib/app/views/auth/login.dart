import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trip_misr/app/controllers/login%20cubit/login_cubit.dart';
import 'package:trip_misr/component/custom_textField.dart';
import 'package:trip_misr/app/views/details/details.dart';
import 'package:trip_misr/utils/app_colors.dart';
import 'package:trip_misr/utils/app_fonts.dart';
import 'package:trip_misr/utils/app_router.dart';
import 'package:trip_misr/utils/loading_indicator.dart';
import 'package:trip_misr/utils/shared_pref.dart';
import 'package:trip_misr/utils/snackBar.dart';
import 'package:trip_misr/utils/user_type.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isSecuredPassword = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
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
                    'Sign In with email and password \n or continue with Social media',
                    style: AppFonts.kLightFont
                        .copyWith(color: AppColors.kLightBlue1, fontSize: 15),
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: _email,
                    lab: 'Email',
                    hint: ' Enter your email',
                    icon: const Icon(Icons.email_outlined),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'This field is required';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return null;
                      }

                      return 'invalid email';
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                      eye: togglePassword(),
                      controller: _password,
                      lab: 'password',
                      hint: ' Enter your password',
                      icon: const Icon(Icons.lock_outlined),
                      isPassword: _isSecuredPassword,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      }),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) async {
                      if (state is LoginLoading) {
                        return showProgressIndicator(context);
                      } else if (state is LoginSuccess) {
                        Navigator.pop(context);
                        mySnackBar(context,
                            sucess: 'You are loggedIn successfully');
                        await ShPref.saveUserType(UserType.oragnizer);
                        GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                      } else {
                        Navigator.pop(context);
                        mySnackBar(context, failed: 'Failed to Log In');
                      }
                    },
                    child: CustomButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          log(_password.text.toString());
                          await BlocProvider.of<LoginCubit>(context)
                              .organizerLogin(_email.text, _password.text);
                        }
                      },
                      child: Text(
                        'Continue',
                        style: AppFonts.kRegularFont
                            .copyWith(color: Colors.white, fontSize: 20.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
        onPressed: () {
          setState(() {
            _isSecuredPassword = !_isSecuredPassword;
          });
        },
        icon: _isSecuredPassword
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }
}
