import 'dart:io';

import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/common/components/text/label_text.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/ticket/controller/ticket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddReplyBottomSheet extends StatefulWidget {
  final String ticketId;
  const AddReplyBottomSheet({super.key, required this.ticketId});

  @override
  State<AddReplyBottomSheet> createState() => _AddReplyBottomSheetState();
}

class _AddReplyBottomSheetState extends State<AddReplyBottomSheet> {
  XFile? imageFile;

  @override
  void dispose() {
    Get.find<TicketController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeaderRow(
            header: LocalStrings.ticketReply.tr,
            bottomSpace: 0,
          ),
          const SizedBox(height: Dimensions.space20),
          CustomTextField(
            labelText: LocalStrings.ticketMessage.tr,
            controller: controller.messageController,
            focusNode: controller.messageFocusNode,
            textInputType: TextInputType.multiline,
            maxLines: 3,
            validator: (value) {
              if (value!.isEmpty) {
                return LocalStrings.enterTicketReply.tr;
              } else {
                return null;
              }
            },
            onChanged: (value) {
              return;
            },
          ),
          const SizedBox(height: Dimensions.space15),
          const LabelText(text: LocalStrings.attachment),
          const SizedBox(height: Dimensions.textToTextSpace),
          InkWell(
            onTap: () {
              _openGallery(context);
            },
            child: buildImage(),
          ),
          const SizedBox(height: Dimensions.space15),
          const SizedBox(height: Dimensions.space25),
          controller.isSubmitLoading
              ? const RoundedLoadingBtn()
              : RoundedButton(
                  text: LocalStrings.submit.tr,
                  press: () {
                    controller.addTicketReply(widget.ticketId);
                  },
                ),
        ],
      );
    });
  }

  Widget buildImage() {
    final Object image;

    if (imageFile != null) {
      image = FileImage(File(imageFile!.path));
    } else {
      image = const AssetImage(MyImages.profile);
    }

    return Container(
        height: 50,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).cardColor,
          border: Border.all(
              color: ColorResources.getTextFieldDisableBorder(), width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageFile != null
                ? ClipOval(
                    child: Material(
                      child: Ink.image(
                        image: image as ImageProvider,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  )
                : Image.asset(MyImages.upload, height: 25),
            const SizedBox(width: 10),
            Text(imageFile != null
                ? imageFile!.name.toString()
                : LocalStrings.selectTicketAttachment.tr),
          ],
        ));
  }

  void _openGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [
          'png',
          'jpg',
          'jpeg',
        ]);
    setState(() {
      Get.find<TicketController>().imageFile = File(result!.files.single.path!);
      imageFile = XFile(result.files.single.path!);
    });
  }
}
