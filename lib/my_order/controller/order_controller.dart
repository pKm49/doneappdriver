import 'dart:developer';
import 'package:doneappdriver/home/controller/landing_screen_controller.dart';
import 'package:doneappdriver/my_order/api/order_details_fetch_service.dart';
import 'package:doneappdriver/my_order/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orderDetails = <OrderModel>[].obs;
  RxList<OrderModel> filteredOrderDetails = <OrderModel>[].obs;
  RxBool isLoading = false.obs;
  RxInt? orderId;
  final landingController = Get.find<LandingScreenController>();
  TextEditingController commentsController = TextEditingController();
  RxBool isDelivered = false.obs;
  RxBool isNotDelivered = false.obs;

  Future fetchOrderDetails() async {
    try {
      isLoading.value = true;
      GetOrderDetailsService().fetchOrderDetails().then((orders) {
        orderDetails.value = orders;
        log(orderDetails.toString());
      });
    } catch (e) {
      isLoading.value = false;
      log("Error while fetching order details");
    } finally {
      isLoading.value = false;
    }
  }

  Future fetchFilteredOrderDetails() async {
    try {
      isLoading.value = true;
      await GetOrderDetailsService().fetchOrderDetails().then((orders) {
        filteredOrderDetails.value = orders;
        landingController.currentIdx.value = 1;
        log(orderDetails.toString(), name: "filtered order list");
      });
    } catch (e) {
      isLoading.value = false;
      log("Error while fetching order details");
    } finally {
      isLoading.value = false;
    }
  }
}
