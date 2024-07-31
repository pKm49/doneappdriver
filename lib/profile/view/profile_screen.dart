import 'package:doneappdriver/auth/view/login_screen.dart';
import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:doneappdriver/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final profileController = Get.find<ProfileController>();
      await profileController.fetchDriverProfile();
    });
    final profileController = Get.find<ProfileController>();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(
          () => profileController.driverProfile.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        kHeight(20),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              profileController.driverProfile[0].image),
                          radius: 60,
                        ),
                        kHeight(20),
                        Text(
                          profileController.driverProfile[0].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          profileController.driverProfile[0].code,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.phone_enabled_outlined,
                                color: kPrimaryColor,
                              )),
                          title: Text(
                            profileController.driverProfile[0].mobile,
                          ),
                        ),
                        kHeight(10),
                        profileController.driverProfile[0].email.isEmpty
                            ? const SizedBox()
                            : ListTile(
                                leading: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.email_outlined,
                                      color: kPrimaryColor,
                                    )),
                                title: Text(
                                  profileController.driverProfile[0].email,
                                ),
                              ),
                        kHeight(10),
                        ListTile(
                          leading: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.lock_open_rounded,
                                color: kPrimaryColor,
                              )),
                          title: const Text("Reset Password"),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: kGreyColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    kHeight(0),
                    ListTile(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("hasSeenWelcomeScreen");
                        Get.offAll(const LoginScreen());
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: kPrimaryColor,
                      ),
                      title: const Text("Log out"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kGreyColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    ));
  }
}
