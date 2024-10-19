// we use the name route
// access the url
// All our routes will be avialable here

import 'package:flutter/material.dart';
import 'package:synergent_task/view/Android/setting/setting_screen.dart';
import 'package:synergent_task/view/splash/splash_screen.dart';

import '../view/Android/android_home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  AndroidHomeScreen.routeName: (context) => const AndroidHomeScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
};
