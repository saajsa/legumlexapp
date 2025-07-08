import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/core/utils/url_container.dart';
import 'package:legumlex_customer/features/contract/controller/contract_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class SignContractBottomSheet extends StatefulWidget {
  final String contractId;
  const SignContractBottomSheet({super.key, required this.contractId});

  @override
  State<SignContractBottomSheet> createState() =>
      _SignContractBottomSheetState();
}

class _SignContractBottomSheetState extends State<SignContractBottomSheet> {
  @override
  void dispose() {
    Get.find<ContractController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.space15,
        children: [
          BottomSheetHeaderRow(
            header: LocalStrings.signContract.tr,
            bottomSpace: 0,
          ),
          CustomTextField(
            labelText: LocalStrings.firstName.tr,
            controller: controller.firstNameController,
            focusNode: controller.firstNameFocusNode,
            nextFocus: controller.lastNameFocusNode,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return LocalStrings.enterFirstName.tr;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              return;
            },
          ),
          CustomTextField(
            labelText: LocalStrings.lastName.tr,
            controller: controller.lastNameController,
            focusNode: controller.lastNameFocusNode,
            nextFocus: controller.emailFocusNode,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return LocalStrings.enterLastName.tr;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              return;
            },
          ),
          CustomTextField(
            labelText: LocalStrings.email.tr,
            controller: controller.emailController,
            focusNode: controller.emailFocusNode,
            textInputType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return LocalStrings.enterEmail.tr;
              } else if (!UrlContainer.emailValidatorRegExp
                  .hasMatch(value ?? '')) {
                return LocalStrings.invalidEmailMsg.tr;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              return;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
            child: Text(LocalStrings.signature.tr, style: lightDefault),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: ColorResources.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(Dimensions.cardRadius),
                ),
                child: Signature(
                  key: const Key('signature'),
                  controller: controller.signatureController,
                  height: 180,
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    controller.signatureController.clear();
                  },
                  child: Container(
                    height: 26,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(Dimensions.cardRadius),
                        bottomLeft: Radius.circular(Dimensions.cardRadius),
                      ),
                    ),
                    child: Text(LocalStrings.clear.tr,
                        style: regularDefault.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          controller.isSubmitLoading
              ? const RoundedLoadingBtn()
              : RoundedButton(
                  text: LocalStrings.submit.tr,
                  press: () {
                    controller.signContract(widget.contractId);
                  },
                ),
        ],
      );
    });
  }
}
