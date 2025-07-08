import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/helper/string_format_helper.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/estimate/model/estimate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimateCard extends StatelessWidget {
  const EstimateCard({
    super.key,
    required this.index,
    required this.estimateModel,
  });
  final int index;
  final EstimatesModel estimateModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.estimateDetailsScreen,
            arguments: estimateModel.data![index].id!);
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                left: BorderSide(
                  width: 5.0,
                  color: ColorResources.estimateStatusColor(
                      estimateModel.data![index].status!),
                ),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${estimateModel.data![index].prefix!}${estimateModel.data![index].number}',
                          style: regularLarge,
                        ),
                        Text(
                          '${estimateModel.data![index].total} ${estimateModel.data![index].currencyName}',
                          style: regularDefault,
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.space5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Converter.estimateStatusString(
                              estimateModel.data![index].status ?? ''),
                          style: lightSmall.copyWith(
                              color: ColorResources.estimateStatusColor(
                                  estimateModel.data![index].status ?? '')),
                        ),
                      ],
                    ),
                    const CustomDivider(space: Dimensions.space10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIcon(
                          text: estimateModel.data![index].clientName ?? '-',
                          icon: Icons.account_box_rounded,
                        ),
                        TextIcon(
                          text: estimateModel.data![index].expiryDate ?? '-',
                          icon: Icons.calendar_month,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
