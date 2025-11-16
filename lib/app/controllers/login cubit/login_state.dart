part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

// ignore: must_be_immutable
final class LoginFailed extends LoginState {
 final String errorMessage;
  LoginFailed(this.errorMessage);
}

final class LoginSuccess extends LoginState {
  final SupabaseUser user;
  LoginSuccess(this.user);
}

final class OrganizerLoginSuccess extends LoginState {}

final class OrganizerLoginLoading extends LoginState {}

final class OrganizerLoginFailed extends LoginState {}

final class LogOutLoading extends LoginState {}

final class LogOutSuccess extends LoginState {}

final class LogOutFailed extends LoginState {}
