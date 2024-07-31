import 'package:doneappdriver/constraints/const_colors.dart';
import 'package:flutter/material.dart';

class TrackOrderContainer extends StatelessWidget {
  const TrackOrderContainer({
    super.key,
    required this.count,
    required this.content,
  });

  final String count;
  final String content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.28,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 2,
            color: Colors.grey.shade400),
      ], color: kPrimaryColor, borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
                fontSize: 26, color: kWhiteColor, fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            style: const TextStyle(color: kWhiteColor, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
