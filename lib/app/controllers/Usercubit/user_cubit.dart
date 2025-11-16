import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:trip_misr/utils/user_type.dart';

part 'user_state.dart';

class HomeCubit extends Cubit<UserState> {
  HomeCubit(UserType userType)
      : super(UserState(currentIndex: 0, userType: userType));

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
