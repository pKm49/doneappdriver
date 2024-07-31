import 'dart:developer';

import 'package:doneappdriver/notification/api/notification_service.dart';
import 'package:doneappdriver/notification/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  Future fetchNotification() async {
    try {
      isLoading.value = true;
      await NotificationAPiService()
          .getNotification()
          .then((notificationsList) => notifications.value = notificationsList);
    } catch (e) {
      isLoading.value = false;
      log("Error while fetching notification list");
    } finally {
      isLoading.value = false;
    }
  }
}
