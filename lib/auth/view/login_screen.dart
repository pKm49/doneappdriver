import 'package:doneappdriver/auth/controller/auth_controller.dart';
import 'package:doneappdriver/auth/view/forget_password.dart/forgot_pass_screen.dart';
import 'package:doneappdriver/auth/view/widget/social_media_login_widget.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/logo/Diet done driver app logo.png",
              height: 90,
            ),
            Form(
              key: authController.authFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: authController.numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your Mobile Number",
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (mobile) => authController.validate(
                        mobile, "Please enter your mobile number"),
                  ),
                  kHeight(10),
                  Obx(
                    () => TextFormField(
                      controller: authController.passwordController,
                      validator: (password) => authController.validate(
                          password, "Please enter your password!"),
                      obscureText: authController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              authController.isPasswordVisible.toggle();
                            },
                            icon: Icon(authController.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_outlined)),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           Get.to(const ForgotPassScreen());
                  //         },
                  //         child: const Text("Forget Password?",
                  //             style: TextStyle(
                  //                 color: kBlackColor,
                  //                 fontWeight: FontWeight.w600))),
                  //   ],
                  // ),
                ],
              ),
            ),
            Obx(
              () => ElevatedButton(
                child: authController.isLoading.value
                    ? const CircularProgressIndicator(
                        color: kWhiteColor,
                      )
                    : Text(
                        "Login",
                        style: theme.textTheme.labelLarge,
                      ),
                onPressed: () async {
                  await authController.onUserLogin();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
