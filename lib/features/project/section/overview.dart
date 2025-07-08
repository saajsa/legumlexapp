import 'package:legumlex_customer/common/components/card/custom_card.dart';
import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/core/helper/string_format_helper.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_container.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_linerprogress.dart';
import 'package:legumlex_customer/features/project/model/project_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key, required this.projectDetailsModel});
  final ProjectDetails projectDetailsModel;

  @override
  Widget build(BuildContext context) {
    int daysLeft = int.parse(DateTime.parse(projectDetailsModel.deadline!)
        .difference(DateTime.now())
        .inDays
        .toString());
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space10),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  projectDetailsModel.name ?? '',
                  style: mediumLarge,
                ),
                Text(
                  projectDetailsModel.statusName?.tr.capitalize ?? '',
                  style: mediumDefault.copyWith(
                      color: ColorResources.projectStatusColor(
                          projectDetailsModel.status ?? '')),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space10),
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocalStrings.customer.tr, style: lightSmall),
                      Text(LocalStrings.billingType.tr, style: lightSmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(projectDetailsModel.clientData?.company ?? '',
                          style: regularDefault),
                      Text(
                          projectDetailsModel.billingType == '1'
                              ? LocalStrings.fixedRate.tr
                              : projectDetailsModel.billingType == '2'
                                  ? LocalStrings.projectHours.tr
                                  : LocalStrings.taskHours.tr,
                          style: regularDefault),
                    ],
                  ),
                  const CustomDivider(space: Dimensions.space10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocalStrings.startDate.tr, style: lightSmall),
                      Text(LocalStrings.deadline.tr, style: lightSmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(projectDetailsModel.startDate ?? '-',
                          style: regularDefault),
                      Text(projectDetailsModel.deadline ?? '-',
                          style: regularDefault),
                    ],
                  ),
                  const CustomDivider(space: Dimensions.space10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocalStrings.totalRate.tr, style: lightSmall),
                      Text(LocalStrings.logged.tr, style: lightSmall),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          projectDetailsModel.billingType == '1'
                              ? projectDetailsModel.projectCost ?? '-'
                              : projectDetailsModel.billingType == '2'
                                  ? '${projectDetailsModel.projectRatePerHour} / ${LocalStrings.hours.tr}'
                                  : projectDetailsModel.projectCost ?? '-',
                          style: regularDefault),
                      Text('00:00', style: regularDefault),
                    ],
                  ),
                  const CustomDivider(space: Dimensions.space10),
                  Text(LocalStrings.description.tr, style: lightSmall),
                  Text(
                      Converter.parseHtmlString(
                          projectDetailsModel.description ?? '-'),
                      style: regularDefault),
                ],
              ),
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                    name: LocalStrings.totalExpenses.tr,
                    number: '0.00',
                    color: Theme.of(context).textTheme.bodyLarge!.color!),
                const SizedBox(width: Dimensions.space10),
                CustomContainer(
                    name: LocalStrings.billableExpenses.tr,
                    number: '0.00',
                    color: ColorResources.colorOrange),
              ],
            ),
            const SizedBox(height: Dimensions.space15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainer(
                    name: LocalStrings.billedExpenses.tr,
                    number: '0.00',
                    color: ColorResources.greenColor),
                const SizedBox(width: Dimensions.space10),
                CustomContainer(
                    name: LocalStrings.unbilledExpenses.tr,
                    number: '0.00',
                    color: ColorResources.redColor),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            CustomLinerProgress(
              color: ColorResources.redColor,
              value: double.parse(projectDetailsModel.progress!) * .01,
              name: LocalStrings.projectProgress.tr,
              data: '${projectDetailsModel.progress!}%',
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              children: [
                Expanded(
                  child: CustomLinerProgress(
                    color: ColorResources.colorOrange,
                    //TODO: get the right value
                    value: 0.8,
                    name: LocalStrings.openTasks.tr,
                    //TODO: get open tasks and total tasks from api
                    data: '2/3',
                  ),
                ),
                const SizedBox(width: Dimensions.space8),
                Expanded(
                  child: CustomLinerProgress(
                    color: ColorResources.greenColor,
                    value: double.parse(daysLeft.toString()) * .01,
                    name: LocalStrings.daysLeft.tr,
                    data:
                        '${daysLeft > 0 ? daysLeft : 0}/${DateTime.parse(projectDetailsModel.deadline!).difference(DateTime.parse(projectDetailsModel.startDate!)).inDays.toString()}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
