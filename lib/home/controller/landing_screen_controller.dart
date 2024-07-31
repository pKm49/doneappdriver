import 'package:doneappdriver/home/view/home_screen.dart';
import 'package:doneappdriver/my_order/view/order_screen.dart';
import 'package:doneappdriver/notification/view/notification_screen.dart';
import 'package:doneappdriver/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreenController extends GetxController {
  RxInt currentIdx = 0.obs;
  RxList<Widget> screens = const [
    HomeScreen(),
    OrderScreen(),
    NotificationScreen(),
    ProfileScreen()
  ].obs;
}
