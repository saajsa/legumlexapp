import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/helper/date_converter.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/contract/model/contract_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractComment extends StatelessWidget {
  const ContractComment({
    super.key,
    required this.index,
    required this.contractDetailsModel,
  });
  final int index;
  final ContractDetailsModel contractDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space20, vertical: Dimensions.space15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contractDetailsModel.data!.comments?[index].content ?? '',
            style: regularSmall,
          ),
          const CustomDivider(space: Dimensions.space10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIcon(
                text: DateConverter.formatValidityDate(
                    contractDetailsModel.data!.comments?[index].dateAdded ??
                        ''),
                icon: Icons.calendar_month,
              ),
              Text(
                contractDetailsModel.data!.comments?[index].staffId != '0'
                    ? '${LocalStrings.staff.tr} #${contractDetailsModel.data!.comments?[index].staffId}'
                    : '',
                style:
                    regularSmall.copyWith(color: ColorResources.blueGreyColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
