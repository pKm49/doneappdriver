import 'dart:developer';

import 'package:doneappdriver/home/api/get_profile_service.dart';
import 'package:doneappdriver/home/model/driver_home_profile_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<GetDriverProfileDetails> driverProfile =
      <GetDriverProfileDetails>[].obs;
  RxBool isLoading = false.obs;
  DateTime? selectedDate;
  int? shiftId;
  Future getDriverProfile() async {
    try {
      isLoading.value = true;
      await GetProfileAPiService().getProfile().then((profile) {
        driverProfile.value = profile;
        log(driverProfile.toString(), name: "driver Profile");
      });
    } catch (e) {
      isLoading.value = false;

      log("Error while fetching driver profile data");
    } finally {
      isLoading.value = false;
    }
  }
}
