import 'package:doneappdriver/auth/view/forget_password.dart/otp_verification_screen.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password?",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(10),
            const Text(
                "Don't worry! It occurs. Please enter the email address linked with your account."),
            kHeight(50),
            TextFormField(
              decoration: const InputDecoration(hintText: "Enter your email"),
            ),
            kHeight(20),
            ElevatedButton(
                onPressed: () {
                  Get.to(const ForgotPasswordOtpScreen());
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Send Code",
                  style: theme.textTheme.labelLarge,
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remember Password?"),
                TextButton(onPressed: () {}, child: const Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
