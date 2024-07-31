import 'dart:developer';

import 'package:doneappdriver/auth/api/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  validate(String? controller, String message) {
    if (controller == null || controller.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  onUserLogin() async {
    if (authFormKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        await LoginApiService().userLogin(
          numberController.text.trim(),
          passwordController.text.trim(),
        );
      } catch (e) {
        isLoading.value = false;

        log("$e");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
