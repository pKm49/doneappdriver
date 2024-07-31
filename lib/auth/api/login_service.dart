import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/home/view/landing_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiService {
  final storage = const FlutterSecureStorage();
  Future<void> userLogin(String mobile, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = await storage.read(key: "access_token");
    final url =
        "${ApiConfig.baseUrl}${ApiConfig.driverLogin}?mobile=$mobile&password=$password";
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      log(response.body.toString());
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      final statusOk = responseData['statusOk'] ?? false;
      final statusCode = responseData['statusCode'];

      if (statusOk && statusCode == 200) {
        prefs.setString("mobile", mobile);
        Get.offAll(const LandingScreen());
      } else {
        final errorMessage = responseData['error'] ?? "Unknown error";
        Get.snackbar(
          "Oops..",
          errorMessage,
        );
      }
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final errorMessage = responseData['error'] ?? "Unknown error";
      Get.snackbar(
        "Oops..",
        errorMessage,
      );
    }
  }
}
