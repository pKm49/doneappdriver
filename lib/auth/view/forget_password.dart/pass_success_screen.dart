import 'package:doneappdriver/auth/view/login_screen.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassChangedSuccessScreen extends StatelessWidget {
  const PassChangedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.10,
              width: size.height * 0.10,
              child: Image.asset(
                "assets/illustration/Successmark.png",
              ),
            ),
            kHeight(20),
            Text(
              "OTP Verification",
              style: theme.textTheme.titleMedium,
            ),
            kHeight(10),
            const Text(
              "Your password has been changed\nsuccessfully.",
              textAlign: TextAlign.center,
            ),
            kHeight(20),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(const LoginScreen());
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                child: Text(
                  "Back to Login",
                  style: theme.textTheme.labelLarge,
                )),
          ],
        ),
      ),
    );
  }
}
