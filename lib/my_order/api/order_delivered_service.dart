import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:doneappdriver/my_order/view/live_tracking_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderDeliveredApiService {
  final storage = FlutterSecureStorage();
  final OrderController orderController = Get.find<OrderController>();
  Future orderDelivered() async {
    orderController.isLoading.value = true;
    final accessToken = await storage.read(key: "access_token");
    final url =
        "${ApiConfig.baseUrl}${ApiConfig.driverDelivered}?order_id=${orderController.orderId}&comments=${orderController.commentsController.text}";
    log(url);
    final response = await http.patch(
        Uri.parse(
          url,
        ),
        headers: {"Authorization": "Bearer $accessToken"});
    log(response.body, name: "Order Delivered");
    if (response.statusCode == 200) {
      orderController.isLoading.value = false;
      Get.to(const LiveTrackingScreen());
      log(response.body, name: "Order Delivered");
      orderController.commentsController.clear();
    } else {
      orderController.isLoading.value = false;

      log("Error while Delivering..");
    }
  }

  Future orderNotDelivered() async {
    orderController.isLoading.value = true;

    final accessToken = await storage.read(key: "access_token");
    final url =
        "${ApiConfig.baseUrl}${ApiConfig.driverNotDelivered}?order_id=${orderController.orderId}&comments=${orderController.commentsController.text}";
    log(url);
    final response = await http.patch(
        Uri.parse(
          url,
        ),
        headers: {"Authorization": "Bearer $accessToken"});
    log(response.body, name: "Order Not Delivered");
    if (response.statusCode == 200) {
      orderController.isLoading.value = false;
      Get.to(const LiveTrackingScreen());

      log(response.body, name: "Order Delivered");
      orderController.commentsController.clear();
    } else {
      orderController.isLoading.value = false;

      log("Error while Not Delivering..");
    }
  }
}
