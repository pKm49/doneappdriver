import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SendDeviceTokenApiService {
  Future sendDeviceTokenToBackEnd() async {
    const url = ApiConfig.baseUrl + ApiConfig.driverDeviceToken;
    const storage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString("mobile");
    final accessToken = await storage.read(key: "access_token");
    String? token = await FirebaseMessaging.instance.getToken();
    log(token.toString(), name: "device token");
    final response = await http.post(Uri.parse(url),
        headers: {"Authorization": "Bearer $accessToken"},
        body: json.encode({"mobile": mobile, "device_token": token}));
    if (response.statusCode == 200) {
      log(response.body, name: "device Token api");
    }
  }
}
