import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/buttons/card_button.dart';
import 'package:legumlex_customer/common/components/card/custom_card.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/contract/controller/contract_controller.dart';
import 'package:legumlex_customer/features/contract/repo/contract_repo.dart';
import 'package:legumlex_customer/features/contract/widget/sign_contract_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ContractDetailsScreen extends StatefulWidget {
  const ContractDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<ContractDetailsScreen> createState() => _ContractDetailsScreenState();
}

class _ContractDetailsScreenState extends State<ContractDetailsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ContractRepo(apiClient: Get.find()));
    final controller = Get.put(ContractController(contractRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadContractDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.contractDetails.tr,
        isShowActionBtn: true,
        actionWidget: IconButton(
          onPressed: () {
            Get.toNamed(RouteHelper.contractCommentsScreen,
                arguments: widget.id);
          },
          icon: const Icon(
            Icons.comment_rounded,
            size: 20,
          ),
        ),
      ),
      body: GetBuilder<ContractController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.contractDetailsModel.data!.subject ??
                                  '',
                              style: mediumLarge,
                            ),
                            controller.contractDetailsModel.data?.signed == '0'
                                ? CardButton(
                                    text: LocalStrings.sign.tr,
                                    icon: Icons.edit_note_outlined,
                                    bgColor: ColorResources.colorGreen,
                                    press: () {
                                      CustomBottomSheet(
                                              child: SignContractBottomSheet(
                                                  contractId: widget.id))
                                          .customBottomSheet(context);
                                    },
                                  )
                                : Text(
                                    LocalStrings.signed.tr,
                                  ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10),
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocalStrings.company.tr,
                                      style: lightSmall),
                                  Text(LocalStrings.contractValue.tr,
                                      style: lightSmall),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      controller.contractDetailsModel.data!
                                              .company ??
                                          '-',
                                      style: regularDefault),
                                  Text(
                                      controller.contractDetailsModel.data!
                                              .contractValue ??
                                          '-',
                                      style: regularDefault),
                                ],
                              ),
                              const CustomDivider(space: Dimensions.space10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocalStrings.startDate.tr,
                                      style: lightSmall),
                                  Text(LocalStrings.endDate.tr,
                                      style: lightSmall),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      controller.contractDetailsModel.data!
                                              .dateStart ??
                                          '-',
                                      style: regularDefault),
                                  Text(
                                      controller.contractDetailsModel.data!
                                              .dateEnd ??
                                          '-',
                                      style: regularDefault),
                                ],
                              ),
                              const CustomDivider(space: Dimensions.space10),
                              Text(LocalStrings.description.tr,
                                  style: lightSmall),
                              Text(
                                  controller.contractDetailsModel.data!
                                          .description ??
                                      '-',
                                  style: regularDefault),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.cardRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.15),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Html(
                              data: controller
                                      .contractDetailsModel.data?.content ??
                                  LocalStrings.noContent.tr),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
