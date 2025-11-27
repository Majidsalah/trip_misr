part of 'user_cubit.dart';

@immutable
class UserState {
  final int currentIndex;
  final UserType userType;

  const UserState({
    required this.currentIndex,
    required this.userType,
  });

  UserState copyWith({
    int? currentIndex,
    UserType? userType,
  }) {
    return UserState(
      currentIndex: currentIndex ?? this.currentIndex,
      userType: userType ?? this.userType,
    );
  }
}

