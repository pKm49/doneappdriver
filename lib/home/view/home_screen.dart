import 'dart:developer';

import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:doneappdriver/home/api/send_device_token.dart';
import 'package:doneappdriver/home/controller/home_controller.dart';
import 'package:doneappdriver/home/view/widgets/curved_clip_path.dart';
import 'package:doneappdriver/home/view/widgets/select_date_custom_button.dart';
import 'package:doneappdriver/home/view/widgets/track_order_widget.dart';
import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await homeController.getDriverProfile();
      await SendDeviceTokenApiService().sendDeviceTokenToBackEnd();
    });

    final size = MediaQuery.of(context).size;
    final orderController = Get.find<OrderController>();
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CurvedClipPath(size: size, color: kPrimaryColor.withOpacity(0.1)),
                  Expanded(
                    child: Container(),
                  ),
                  CurvedClipPath2(size: size, color: kPrimaryColor.withOpacity(0.1))
                ],
              ),
            ),
            Container(
              child:Obx(
                    () => homeController.driverProfile.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView(
                  children: [
                    kHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                homeController.driverProfile[0].image),
                          ),
                          kWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                homeController.driverProfile[0].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(homeController.driverProfile[0].code)
                            ],
                          )
                        ],
                      ),
                    ),
                    kHeight(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        "Track orders",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    kHeight(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TrackOrderContainer(
                            count: homeController.driverProfile[0].totalOrders
                                .toString(),
                            content: "Total orders",
                          ),
                          TrackOrderContainer(
                            count: homeController
                                .driverProfile[0].deliveredOrders
                                .toString(),
                            content: "Delivered",
                          ),
                          TrackOrderContainer(
                            count: homeController
                                .driverProfile[0].pendingOrders
                                .toString(),
                            content: "Pending Order",
                          ),
                        ],
                      ),
                    ),
                    kHeight(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        "Filter Task",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    kHeight(20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 2,
                                color: Colors.grey.shade300),
                          ]),
                      child: Column(
                        children: [
                          const Text(
                            "Dispatch Date",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          kHeight(30),
                          SelectDateCustomButton(
                              homeController: homeController),
                          kHeight(20),
                          selectShiftDropDown(homeController),
                          kHeight(40),
                          Obx(
                                () => ElevatedButton(
                              onPressed: () async {
                                if (homeController.selectedDate == null ||
                                    homeController.shiftId == null) {
                                  Get.snackbar(
                                      "Please Select filter option",
                                      "Make sure that you have selected Date and Shift");
                                } else {
                                  await orderController
                                      .fetchFilteredOrderDetails();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25)),
                                  backgroundColor: kBlackColor,
                                  maximumSize:
                                  const Size(double.infinity, 45)),
                              child: orderController.isLoading.value
                                  ? CircularProgressIndicator(
                                color: kWhiteColor,
                              )
                                  : Text(
                                "Continue",
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField selectShiftDropDown(HomeController homeController) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: 'Select Shift',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.grey,
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kBlackColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDADADA)),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
      ),
      value: null,
      onChanged: (newValue) {
        homeController.shiftId = newValue;
        homeController.update();
      },
      items: homeController.driverProfile[0].shifts.map((shift) {
        return DropdownMenuItem(
          value: shift.id,
          child: Text(
            shift.name,
            style: const TextStyle(fontSize: 15),
          ),
        );
      }).toList(),
    );
  }
}
