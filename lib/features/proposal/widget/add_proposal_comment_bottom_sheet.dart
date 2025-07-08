import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/proposal/controller/proposal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProposalCommentBottomSheet extends StatefulWidget {
  final String proposalId;
  const AddProposalCommentBottomSheet({super.key, required this.proposalId});

  @override
  State<AddProposalCommentBottomSheet> createState() =>
      _AddProposalCommentBottomSheetState();
}

class _AddProposalCommentBottomSheetState
    extends State<AddProposalCommentBottomSheet> {
  @override
  void dispose() {
    Get.find<ProposalController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProposalController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeaderRow(
            header: LocalStrings.addComment.tr,
            bottomSpace: 0,
          ),
          const SizedBox(height: Dimensions.space20),
          CustomTextField(
            labelText: LocalStrings.comment.tr,
            controller: controller.commentController,
            focusNode: controller.commentFocusNode,
            textInputType: TextInputType.multiline,
            maxLines: 3,
            validator: (value) {
              if (value!.isEmpty) {
                return LocalStrings.enterComment.tr;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              return;
            },
          ),
          const SizedBox(height: Dimensions.space25),
          controller.isSubmitLoading
              ? const RoundedLoadingBtn()
              : RoundedButton(
                  text: LocalStrings.submit.tr,
                  press: () {
                    controller.addProposalComment(widget.proposalId);
                  },
                ),
        ],
      );
    });
  }
}
