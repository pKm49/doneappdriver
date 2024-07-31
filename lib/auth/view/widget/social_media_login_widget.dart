import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomSocialButton(
            color: kGreyColor,
            size: size,
            imageUrl: "assets/social_media_logo/google_ic.svg"),
        GestureDetector(
          onTap: () async {},
          child: CustomSocialButton(
            size: size,
            imageUrl: "assets/social_media_logo/facebook_ic.svg",
            color: kGreyColor,
          ),
        ),
        CustomSocialButton(
            size: size,
            imageUrl: 'assets/social_media_logo/cib_apple.svg',
            color: kGreyColor),
      ],
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton(
      {super.key,
      required this.size,
      required this.imageUrl,
      this.onTap,
      required this.color});

  final Size size;
  final String imageUrl;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.13,
      width: size.width * 0.25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SvgPicture.asset(imageUrl),
      ),
    );
  }
}
