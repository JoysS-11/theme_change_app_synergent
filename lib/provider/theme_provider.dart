import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void resetToDefaultTheme() {
    themeMode = ThemeMode.system;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: AppColors.backgroundlightColor,
      selectionHandleColor: AppColors.backgrounddarklightColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.black.withOpacity(.48);
        }
        return AppColors.black;
      }),
    ),
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.white,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: AppColors.white),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CustomTransitionBuilder(),
      TargetPlatform.android: CustomTransitionBuilder(),
    }),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.secondary,
        minimumSize: const Size(0, 40),
      ),
    ),
    inputDecorationTheme: inputDecorationThemeDark(),
  );

  static final lightTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: AppColors.backgroundlightColor,
      selectionHandleColor: AppColors.backgrounddarklightColor,
    ),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: AppColors.black, opacity: 0.8),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CustomTransitionBuilder(),
      TargetPlatform.android: CustomTransitionBuilder(),
    }),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        minimumSize: const Size(0, 40),
      ),
    ),
    inputDecorationTheme: inputDecorationThemeLight(),
  );
}

InputDecorationTheme inputDecorationThemeLight() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: AppColors.black),
    borderRadius: BorderRadius.circular(8),
    gapPadding: 3,
  );
  return InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: AppColors.black),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
      prefixIconColor: AppColors.black);
}

InputDecorationTheme inputDecorationThemeDark() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1, color: AppColors.white),
    borderRadius: BorderRadius.circular(8),
    gapPadding: 3,
  );
  return InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.white),
      floatingLabelStyle: const TextStyle(color: AppColors.white),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
      prefixIconColor: AppColors.white);
}

class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: tween.animate(animation), child: child);
  }
}
