import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:noviindus_machine_test/Constants/Size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Screen.dart';
import 'Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    tokencheck();
  }

  tokencheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("logintoken");
    if (token != null) {
      Timer(const Duration(seconds: 4), (() {
        Get.off(
          () => const HomeScreen(),
          transition: Transition.upToDown,
        );
      }));
    } else {
      Timer(const Duration(seconds: 4), (() {
        Get.off(
          () => const LoginScreen(),
          transition: Transition.upToDown,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Image.asset(
          "assets/splash_image.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
