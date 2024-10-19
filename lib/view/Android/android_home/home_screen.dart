// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:synergent_task/networking/shared_service.dart';
import 'package:synergent_task/view/Android/setting/setting_screen.dart';
import 'package:synergent_task/view/home/common_home_screen.dart';

import '../../../routing/route_names.dart';

class AndroidHomeScreen extends StatelessWidget {
  static const String routeName = RouteNames.home;
  const AndroidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Android Home",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //  Logout button
                  IconButton(
                    onPressed: () async {
                      await SharedService.userLogout(context).then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CommonHomeScreen()),
                          (route) => false,
                        );
                      });
                    },
                    icon: Icon(
                      Icons.logout_rounded,
                      size: size.height * 0.03,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Home Screen",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SettingScreen.routeName);
                        },
                        child: Text(
                          "Go to Theme Setting...",
                          style: TextStyle(fontSize: size.height * 0.014),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
