import 'dart:developer';

import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/home/controller/landing_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkNotificationsPermission();
  }
  @override
  Widget build(BuildContext context) {
    final landingScreenController = Get.find<LandingScreenController>();
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontSize: 10),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: kBlackColor,
          selectedItemColor: kPrimaryColor,
          currentIndex: landingScreenController.currentIdx.value,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icon/home icon.svg",
                    color: landingScreenController.currentIdx == 0
                        ? kPrimaryColor
                        : kBlackColor),
                label: "Home"),
            BottomNavigationBarItem(
                label: "My Orders",
                icon: SvgPicture.asset("assets/icon/Delivery.svg",
                    color: landingScreenController.currentIdx == 1
                        ? kPrimaryColor
                        : kBlackColor)),
            BottomNavigationBarItem(
              label: "Notification",
              icon: SvgPicture.asset("assets/icon/Notification.svg",
                  color: landingScreenController.currentIdx == 2
                      ? kPrimaryColor
                      : kBlackColor),
            ),
            BottomNavigationBarItem(
                label: "Profile",
                icon: SvgPicture.asset("assets/icon/Person.svg",
                    color: landingScreenController.currentIdx == 3
                        ? kPrimaryColor
                        : kBlackColor)),
          ],
          onTap: (idx) {
            landingScreenController.currentIdx.value = idx;
          },
        ),
      ),
      body: Obx(() => landingScreenController
          .screens[landingScreenController.currentIdx.value]),
    );
  }

  Future<void> checkNotificationsPermission() async {
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        if(!await getPermissionRequestSharedPreference()){
          showPermissionDialogue();
        }
      }
    });
  }

  void showPermissionDialogue( ) async {
    setPermissionRequestSharedPreference();

    final dialogTitleWidget = Text('notification_access_permission_title'.tr);
    final dialogTextWidget = Text( 'notification_access_permission_info'.tr );

    final updateButtonTextWidget = Text('continue'.tr,style: TextStyle(color: kWhiteColor),);

    updateAction() {
      Navigator.pop(context);
      Permission.notification.request();
    }

    List<Widget> actions = [


      ElevatedButton(
          onPressed:updateAction,
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            child:AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );
  }

  Future<bool> getPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isNotificationPermissionAsked = prefs.getBool('isNotificationPermissionAsked');
    print("getPermissionRequestSharedPreference");
    print(isNotificationPermissionAsked);
    return isNotificationPermissionAsked !=null?isNotificationPermissionAsked:false;
  }

  Future<void> setPermissionRequestSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNotificationPermissionAsked',true);
  }
}
