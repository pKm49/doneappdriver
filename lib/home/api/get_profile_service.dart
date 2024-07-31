import 'dart:convert';
import 'dart:developer';

import 'package:doneappdriver/core/api/const_api_endpoints.dart';
import 'package:doneappdriver/home/model/driver_home_profile_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetProfileAPiService {
  final storage = const FlutterSecureStorage();
  Future<List<GetDriverProfileDetails>> getProfile() async {
    final accessToken = await storage.read(key: "access_token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final mobile = prefs.getString("mobile");
    final url = "${ApiConfig.baseUrl}${ApiConfig.driveHome}?mobile=$mobile";
    log(mobile.toString(), name: "user mobile number");
    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      log(response.body.toString());
      final List<dynamic> responseData = json.decode(response.body)["payload"];
      final List<GetDriverProfileDetails> driverProfile = responseData
          .map((json) => GetDriverProfileDetails.fromJson(json))
          .toList();
      return driverProfile;
    } else {
      throw Exception("Failed to fetch driver profile data");
    }
  }
}
