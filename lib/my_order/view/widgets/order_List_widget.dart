import 'dart:developer';

import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:doneappdriver/my_order/view/order_track_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile({
    super.key,
    required this.orderController,
  });

  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight(10),
        const Text(
          "Current Shipment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        kHeight(10),
        Text(orderController.orderDetails.isEmpty
            ? "There is no order today"
            : "Today Orders ${orderController.orderDetails.length}"),
        kHeight(10),
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final orderDetails = orderController.orderDetails[index];
                  return orderController.orderDetails.isEmpty
                      ? const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.notification_important_outlined,
                                color: Colors.black,
                              ),
                              Text("There is no Order Today")
                            ],
                          ),
                        )
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(orderDetails.image),
                                ),
                                kWidth(10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderDetails.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      kHeight(5),
                                      Text(
                                        "Street: ${orderDetails.street} Jedha: ${orderDetails.jedha} House Number: ${orderDetails.houseNumber} Floor Number: ${orderDetails.floorNumber}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style:
                                            const TextStyle(color: kGreyColor),
                                      ),
                                      kHeight(10),
                                      InkWell(
                                        onTap: () {
                                          orderController.orderId =
                                              orderDetails.id.obs;
                                          log(
                                              orderController.orderId
                                                  .toString(),
                                              name: "Order Id");
                                          Get.to(const TrackDetailsScreen());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Text(
                                            "Track",
                                            style:
                                                TextStyle(color: kWhiteColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                },
                separatorBuilder: (context, index) => kHeight(10),
                itemCount: orderController.orderDetails.length))
      ],
    );
  }
}
