import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:doneappdriver/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        title: const Text("Live Tracking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Location Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  kHeight(10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                              "assets/icon/Location Details.svg"),
                        ),
                        const Expanded(
                          child: Text(
                              "1234 Elm Street, Springfield, Anytown,State of Confusion, Country of Imagination,..."),
                        )
                      ],
                    ),
                  ),
                  kHeight(15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.circular(60)),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/background_image/pexels-italo-melo-2379005.jpg"),
                          radius: 25,
                        ),
                        kWidth(10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kayna alis",
                              style: TextStyle(color: kWhiteColor),
                            ),
                            Text(
                              "#666",
                              style: TextStyle(color: kWhiteColor),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: IconButton(
                              onPressed: () async {
                                await redirectToWhatsApp();
                              },
                              icon:
                                  SvgPicture.asset("assets/icon/Message.svg")),
                        ),
                        kWidth(10),
                        CircleAvatar(
                          backgroundColor: kWhiteColor,
                          child: IconButton(
                              onPressed: () {
                                UrlLauncher.launch('tel: 8590708332');
                              },
                              icon: SvgPicture.asset("assets/icon/Call.svg")),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> redirectToWhatsApp() async {
    final phoneNumber = '+918590708332';

    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launchUrlString(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
