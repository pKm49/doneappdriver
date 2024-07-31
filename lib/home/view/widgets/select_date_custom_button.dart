import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class SelectDateCustomButton extends StatelessWidget {
  const SelectDateCustomButton({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary:
                      kBlackColor, // Customize the color of the selected date
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          homeController.selectedDate = pickedDate;
          homeController.update();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor), // Define your border color
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<HomeController>(
            builder: (controller) => Text(
              homeController.selectedDate == null
                  ? 'Select Date'
                  : DateFormat('yy-MM-dd').format(homeController.selectedDate!),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: homeController.selectedDate == null
                    ? Colors.grey
                    : kBlackColor,
              ),
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
