import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/my_order/model/order_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetOrderDetailsService {
  final storage = const FlutterSecureStorage();
  Future<List<OrderModel>> fetchOrderDetails() async {
    final accessToken = await storage.read(key: "access_token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.driverOrder}?mobile=$mobile";
    log(mobile.toString(), name: "user mobile number");
    log(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    log(response.body.toString());
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
