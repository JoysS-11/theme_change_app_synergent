// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:synergent_task/view/home/common_home_screen.dart';

import '../../routing/route_names.dart';
import '../widgets/slide_fade_transition.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = RouteNames.splash;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      gotoHomeScreen();
    });
  }

  void gotoHomeScreen() async {
    timer = Timer(const Duration(), () {
      Navigator.pushAndRemoveUntil(
        context,
        _createRoute(),
        (route) => false,
      );
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CommonHomeScreen(),
      transitionDuration: const Duration(microseconds: 7000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SlideFadeTransition(
            delayStart: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 2,
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
