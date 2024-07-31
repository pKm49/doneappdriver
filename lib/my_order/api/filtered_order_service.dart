import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/home/controller/home_controller.dart';
import 'package:doneappdriver/home/controller/landing_screen_controller.dart';
import 'package:doneappdriver/my_order/model/order_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilterOrderDetailsService {
  final storage = const FlutterSecureStorage();
  final homeController = Get.find<HomeController>();

  Future<List<OrderModel>> fetchOrderDetails() async {
    final accessToken = await storage.read(key: "access_token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString("mobile");
    final url =
        "${ApiConfig.baseUrl}${ApiConfig.driverOrder}?mobile=$mobile&date=${homeController.selectedDate}&shift_id=${homeController.shiftId!}";
    log(mobile.toString(), name: "user mobile number");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      log(response.body.toString());
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<OrderModel> orderDetails =
          responseData.map((json) => OrderModel.fromJson(json)).toList();

      return orderDetails;
    } else {
      throw Exception("Failed to fetch driver profile data");
    }
  }
}
