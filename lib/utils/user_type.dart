import 'dart:developer';

import 'package:trip_misr/utils/shared_pref.dart';

enum UserType { oragnizer, normal, guest }

UserType currentUserType() {
  final currentUserType = ShPref.getUserType();
  log(currentUserType.toString());
  return currentUserType;
}
