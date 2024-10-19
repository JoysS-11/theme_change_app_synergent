// ignore_for_file: avoid_print, unused_local_variable

// import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

class SharedService {
  static Future<VoidCallback?> setUserDetails(
    dynamic user,
  ) async {
    final SharedPreferences storage = await _storage;
    // final cacheDBModel = jsonEncode(user.toJson());
    await storage.setString("user_login_syner", user.toString());
    return null;
  }

  static Future<String?> userIsLoggedIn() async {
    final SharedPreferences storage = await _storage;
    var user = storage.getString('user_login_syner');
    return user;
  }

  static Future<VoidCallback?> userLogout(context) async {
    final SharedPreferences storage = await _storage;
    await storage.remove("user_login_syner");
    return null;
  }
}
