import 'package:doneappdriver/auth/controller/auth_controller.dart';
import 'package:doneappdriver/home/controller/home_controller.dart';
import 'package:doneappdriver/home/controller/landing_screen_controller.dart';
import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:doneappdriver/notification/controller/notification_controller.dart';
import 'package:doneappdriver/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class InitDependency extends Bindings {
  @override
  void dependencies() {
    Get.put(LandingScreenController());
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(OrderController());
    Get.put(ProfileController());
    Get.put(NotificationController());
  }
}
