import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:legumlex_customer/common/components/text/bottom_sheet_header_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';

class BottomSheetHeaderRow extends StatelessWidget {
  final String header;
  final double bottomSpace;
  const BottomSheetHeaderRow(
      {super.key, this.header = '', this.bottomSpace = Dimensions.space10});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorResources.colorGrey.withValues(alpha: 0.2),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: BottomSheetHeaderText(text: header.tr)),
            const BottomSheetCloseButton()
          ],
        ),
        SizedBox(height: bottomSpace),
      ],
    );
  }
}
