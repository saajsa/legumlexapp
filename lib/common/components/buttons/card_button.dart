import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:get/get.dart';

class CardButton extends StatelessWidget {
  final VoidCallback press;
  final IconData icon;
  final String? text;
  final Color bgColor;
  final Color contentColor;
  final bool isText;

  const CardButton(
      {super.key,
      this.text,
      required this.icon,
      this.isText = true,
      this.bgColor = ColorResources.primaryColor,
      this.contentColor = ColorResources.colorWhite,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space10, horizontal: Dimensions.space15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: contentColor, size: 15),
            isText
                ? const SizedBox(width: Dimensions.space8)
                : const SizedBox(),
            isText
                ? Text(text?.tr ?? '',
                    style: regularSmall.copyWith(color: contentColor),
                    overflow: TextOverflow.ellipsis)
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
