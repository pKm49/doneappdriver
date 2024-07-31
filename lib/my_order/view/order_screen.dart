import 'package:doneappdriver/my_order/controller/order_controller.dart';
import 'package:doneappdriver/my_order/view/widgets/filtered_order_list_widget.dart';
import 'package:doneappdriver/my_order/view/widgets/order_List_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final orderController = Get.find<OrderController>();
      await orderController.fetchOrderDetails();
    });
    final orderController = Get.find<OrderController>();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () {
            if (orderController.orderDetails.isEmpty &&
                orderController.filteredOrderDetails.isEmpty) {
              return Center(
                child: Text("There is no Order Today"),
              );
            } else if (orderController.filteredOrderDetails.isEmpty) {
              return OrderListTile(orderController: orderController);
            } else {
              return FilterOrderListTile(orderController: orderController);
            }
          },
        ),
      ),
    ));
  }
}
