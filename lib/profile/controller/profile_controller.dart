import 'dart:async';
import 'dart:developer';

import 'package:doneappdriver/profile/api/get_driver_profile_service.dart';
import 'package:doneappdriver/profile/model/driver_profile_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxList<DriverProfileModel> driverProfile = <DriverProfileModel>[].obs;
  RxBool isLoading = false.obs;

  Future fetchDriverProfile() async {
    try {
      isLoading.value = true;
      await GetDriverProfileAPiService()
          .getProfile()
          .then((profile) => driverProfile.value = profile);
    } catch (e) {
      log("Error while fetching DRIVER PROFILE");
    } finally {
      isLoading.value = false;
    }
  }
}
