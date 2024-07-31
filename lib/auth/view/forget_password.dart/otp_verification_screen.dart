import 'package:doneappdriver/auth/view/forget_password.dart/create_new_pass_screen.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({
    super.key,
  });

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
              "OTP Verification",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(10),
            const Text(
                "Enter the verification code we just sent on your email address."),
            kHeight(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  defaultPinTheme: PinTheme(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200])),
                  submittedPinTheme: const PinTheme(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: kBlackColor))),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            kHeight(20),
            ElevatedButton(
                onPressed: () {
                  Get.to(const CreateNewPassScreen());
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Verify",
                  style: theme.textTheme.labelLarge,
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't received code?"),
                TextButton(onPressed: () {}, child: const Text("Resend"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
