import 'package:doneappdriver/auth/view/forget_password.dart/pass_success_screen.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPassScreen extends StatelessWidget {
  const CreateNewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create new password",
                style: theme.textTheme.titleMedium,
              ),
              kHeight(10),
              const Text(
                  "Your new password must be unique from those previously used."),
              kHeight(50),
              TextFormField(
                decoration: const InputDecoration(hintText: "New Password"),
              ),
              kHeight(10),
              TextFormField(
                decoration: const InputDecoration(hintText: "Confirm Password"),
              ),
              kHeight(20),
              ElevatedButton(
                  onPressed: () {
                    Get.to(const PassChangedSuccessScreen());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                  child: Text(
                    "Reset Password",
                    style: theme.textTheme.labelLarge,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
