import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';
import '../../../routing/route_names.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = RouteNames.setting;
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  bool changeTheme = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    themeValidation();
  }

  themeValidation() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    if (isDarkMode != true) {
      changeTheme = false;
    } else {
      changeTheme = true;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Called whenever the platform's brightness changes
  @override
  void didChangePlatformBrightness() {
    themeValidation();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: size.height * 0.03,
                    ),
                  ),
                  Text(
                    "Theme Setting",
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Theme change button
                    switchButton(
                      changeTheme == true ? "Dark Theme" : "Light Theme",
                      changeTheme,
                      (bool value) {
                        setState(() {
                          changeTheme = value;
                          themeNotifier.toggleTheme(value);
                        });
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Default theme button
                    TextButton(
                      onPressed: () {
                        themeNotifier.resetToDefaultTheme();
                        themeValidation();
                      },
                      child: Text(
                        "Default Theme",
                        style: TextStyle(fontSize: size.height * 0.012),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row switchButton(String text, bool value, void Function(bool) onChanged) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size.height * 0.014,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
