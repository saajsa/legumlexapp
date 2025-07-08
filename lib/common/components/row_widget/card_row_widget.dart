import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/style.dart';

class CardRow extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;

  const CardRow(
      {super.key,
      this.alignmentEnd = false,
      required this.header,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header.tr,
          style: regularSmall.copyWith(
              color: ColorResources.getTextColor().withValues(alpha: 0.6)),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.space5),
        Text(body.tr,
            style: regularDefault.copyWith(
                color: ColorResources.getTextColor(),
                fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis)
      ],
    );
  }
}
