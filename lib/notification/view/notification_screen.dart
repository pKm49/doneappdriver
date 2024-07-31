import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:doneappdriver/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationController.fetchNotification();
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Notifications",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Obx(() => notificationController.notifications.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Icon(Icons.notification_important_sharp),
                          Text("You don't have any notifications")
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => Card(
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icon/Notification.svg"),
                                      kWidth(15),
                                      Expanded(
                                          child: Text(notificationController
                                              .notifications[index].message))
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => kHeight(10),
                          itemCount:
                              notificationController.notifications.length),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
