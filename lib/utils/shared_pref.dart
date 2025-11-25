import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_misr/utils/user_type.dart';

class ShPref {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String _key = "user_type";

  static saveUserType(UserType type) {
    sharedPreferences.setInt(_key, type.index);
  }

  static saveUserAvatar(String userAvatarUrl) {
    sharedPreferences.setString("avatar_url", userAvatarUrl);
  }

  static saveUserId(String userId) {
    sharedPreferences.setString("userId", userId);
  }
    static getUserId() {
    sharedPreferences.get("userId");
  }
  static String? getUserAvatar() {
  return sharedPreferences.getString("avatar_url");
}

  static UserType getUserType() {
    final index = sharedPreferences.getInt(_key);

    if (index == null) {
      return UserType.guest; // default
    }
    return UserType.values[index];
  }

  static clearUserType() {
    sharedPreferences.remove(_key);
  }
}
