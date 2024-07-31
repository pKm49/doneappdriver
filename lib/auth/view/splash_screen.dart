import 'dart:async';

import 'package:doneappdriver/auth/api/get_access_token.dart';
import 'package:doneappdriver/auth/view/login_screen.dart';
import 'package:doneappdriver/auth/view/welcome_screen.dart';
import 'package:doneappdriver/home/view/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      await callAccessTokenEvery24hr();
      redirectToNextScreen();
    });

    super.initState();
  }

  Future<void> callAccessTokenEvery24hr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lastTokenCallTime = prefs.getInt('lastTokenCallTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final durationInMilliseconds = Duration(hours: 24).inMilliseconds;
    await GetAccessTokenService().getAccessToken();

    if (currentTime - lastTokenCallTime > durationInMilliseconds) {
      await GetAccessTokenService().getAccessToken();
      prefs.setInt('lastTokenCallTime', currentTime);
    }

    Timer(const Duration(hours: 24), callAccessTokenEvery24hr);
  }

  Future<void> redirectToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasSeenWelcomeScreen = prefs.getBool("hasSeenWelcomeScreen");

    if (hasSeenWelcomeScreen == null || hasSeenWelcomeScreen == false) {
      Get.off(() => const WelcomeScreen());
    } else {
      final mobile = prefs.getString("mobile");
      if (mobile == null || mobile.isEmpty) {
        Get.off(() => const LoginScreen());
      } else {
        Get.off(() => const LandingScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Image(image: AssetImage("assets/gif/diet_done.gif"))),
    );
  }
}
