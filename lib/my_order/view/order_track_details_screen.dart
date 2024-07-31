import 'dart:developer';

import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:doneappdriver/my_order/api/order_delivered_service.dart';
import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:doneappdriver/my_order/view/live_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TrackDetailsScreen extends StatelessWidget {
  const TrackDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                  "assets/background_image/pexels-italo-melo-2379005.jpg"),
            ),
            const Text(
              "Kayna Alisa",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade200),
              child: const Text("#6666"),
            ),
            const Row(
              children: [
                Text(
                  "Customer Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.location_on,
                    color: kPrimaryColor,
                    size: 35,
                  ),
                ),
                Expanded(
                  child: Text(
                      maxLines: 4,
                      "1234 Elm Street, Springfield, Anytown,State of Confusion, Country of Imagination,Postal Code: 98765-4321"),
                )
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                    size: 35,
                  ),
                ),
                Expanded(
                  child: Text(maxLines: 4, "+965- 5548876"),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                OrderDeliveredApiService().orderDelivered();
              },
              child: Text(
                "Login",
                style: theme.textTheme.labelLarge,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      orderController.isDelivered.value = true;
                      orderController.isNotDelivered.value = false;
                      log(orderController.isDelivered.toString());
                      log(orderController.isNotDelivered.toString());
                    },
                    child: Obx(
                      () => Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: orderController.isDelivered != true
                                  ? kGreyColor
                                  : kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          "Delivered",
                          style: TextStyle(color: kPrimaryColor),
                        )),
                      ),
                    ),
                  ),
                ),
                kWidth(15),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      orderController.isNotDelivered.value = true;
                      orderController.isDelivered.value = false;
                      log(orderController.isDelivered.toString());
                      log(orderController.isNotDelivered.toString());
                    },
                    child: Obx(
                      () => Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: orderController.isNotDelivered != true
                                  ? kGreyColor
                                  : kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          "Not Delivered",
                          style: TextStyle(color: kPrimaryColor),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Your Commands",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: orderController.commentsController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: "Type Here..."),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (orderController.commentsController.text.isEmpty) {
                    Get.snackbar("Please add your Comment",
                        "Type your comment on given field");
                  } else if (orderController.isDelivered == false &&
                      orderController.isNotDelivered == false) {
                    Get.snackbar("Please Select any option",
                        "Delivered Or Not Delivered");
                  } else if (orderController.isDelivered == true) {
                    await OrderDeliveredApiService().orderDelivered();
                  } else {
                    await OrderDeliveredApiService().orderNotDelivered();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kBlackColor,
                    minimumSize: const Size(double.infinity, 55)),
                child: Text(
                  "Submit",
                  style: TextStyle(color: kWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
