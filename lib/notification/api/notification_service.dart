import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/notification/model/notification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationAPiService {
  Future<List<NotificationModel>> getNotification() async {
    const storage = FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    final accessToken = await storage.read(key: "access_token");
    final mobile = prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.driverNotification}/$mobile";
    log(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "notification response");
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<NotificationModel> notification =
          responseData.map((e) => NotificationModel.fromJson(e)).toList();

      return notification;
    } else {
      throw Exception("Error while fetching notification data");
    }
  }
}
