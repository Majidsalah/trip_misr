import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:trip_misr/app/data/models/user_model.dart';
import 'package:trip_misr/app/data/repositories/authRepo.dart';
import 'package:trip_misr/utils/user_type.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final Authrepo authrepo = Authrepo();
  Future<void> userLogIn() async {
    emit(LoginLoading());
    final response = await authrepo.googleLogIn();
    log(response.toString());
    response.fold(
      (failure) => emit(LoginFailed(failure.message)),
      (sucess) => emit(LoginSuccess(sucess as SupabaseUser)),
    );
  }

  Future<void> organizerLogin(String email, String password) async {
    emit(LoginLoading());
    final response = await authrepo.organizerLogIn(email, password);

    response.fold(
      (failure) => emit(LoginFailed(failure.message),),
      (sucess) => emit(LoginSuccess(sucess)),
    );
  }

  Future<void> logout(UserType currentUserType,BuildContext context) async {
    emit(LogOutLoading());
    try {
      await authrepo.userLogOut(currentUserType,context);
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutFailed());
    }
  }
 isSessionActive(){
  authrepo.userChecker();
}
}
// 