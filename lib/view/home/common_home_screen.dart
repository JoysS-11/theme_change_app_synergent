import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:synergent_task/networking/shared_service.dart';
import 'package:synergent_task/view/Android/android_home/home_screen.dart';
import 'package:synergent_task/view/Web/web_home/web_home_screen.dart';

import '../Android/login/login_screen.dart';
import '../Web/web_login/web_login_screen.dart'; // for kIsWeb

class CommonHomeScreen extends StatefulWidget {
  const CommonHomeScreen({super.key});

  @override
  State<CommonHomeScreen> createState() => _CommonHomeScreenState();
}

class _CommonHomeScreenState extends State<CommonHomeScreen> {
  String platformType = '';
  String? isLogedin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Platform finder
    if (kIsWeb) {
      platformType = 'Web';
    }

    getData();
  }

  // Get User login status in local strorage
  getData() async {
    var user = await SharedService.userIsLoggedIn();
    setState(() {
      isLogedin = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return platformType == 'Web'
        // Web Screen
        ? isLogedin != null
            ? const WebHomeScreen()
            : const WebLoginScreen()
        // Android Screen
        : isLogedin != null
            ? const AndroidHomeScreen()
            : const AndroidLoginScreen();
  }
}
