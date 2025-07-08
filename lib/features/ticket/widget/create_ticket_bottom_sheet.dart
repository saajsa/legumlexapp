import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/common/components/text/label_text.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/ticket/controller/ticket_controller.dart';
import 'package:legumlex_customer/features/ticket/model/departments_model.dart';
import 'package:legumlex_customer/features/ticket/model/priorities_model.dart';
import 'package:legumlex_customer/features/ticket/repo/ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicketBottomSheet extends StatefulWidget {
  const CreateTicketBottomSheet({super.key});

  @override
  State<CreateTicketBottomSheet> createState() =>
      _CreateTicketBottomSheetState();
}

class _CreateTicketBottomSheetState extends State<CreateTicketBottomSheet> {
  XFile? imageFile;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TicketRepo(apiClient: Get.find()));
    final controller = Get.put(TicketController(ticketRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadTicketCreateData();
    });
  }

  @override
  void dispose() {
    Get.find<TicketController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketController>(builder: (controller) {
      return controller.isLoading
          ? const CustomLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeaderRow(
                  header: LocalStrings.createNewTicket.tr,
                  bottomSpace: 0,
                ),
                const SizedBox(height: Dimensions.space20),
                CustomTextField(
                  labelText: LocalStrings.subject.tr,
                  controller: controller.subjectController,
                  focusNode: controller.subjectFocusNode,
                  textInputType: TextInputType.text,
                  nextFocus: controller.departmentFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocalStrings.enterTicketSubject.tr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    return;
                  },
                ),
                const SizedBox(height: Dimensions.space15),
                CustomDropDownTextField(
                  labelText: LocalStrings.department.tr,
                  onChanged: (value) {
                    controller.departmentController.text = value;
                  },
                  hintText: LocalStrings.selectDepartment.tr,
                  items:
                      controller.departmentModel.data!.map((Department value) {
                    return DropdownMenuItem(
                      value: value.id,
                      child: Text(
                        value.name?.tr ?? '',
                        style: regularDefault.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.space15),
                CustomDropDownTextField(
                  needLabel: true,
                  labelText: LocalStrings.priority.tr,
                  onChanged: (value) {
                    controller.priorityController.text = value.toString();
                  },
                  hintText: LocalStrings.selectPriority.tr,
                  items: controller.priorityModel.data!.map((Priority value) {
                    return DropdownMenuItem(
                      value: value.id,
                      child: Text(
                        value.name?.tr ?? '',
                        style: regularDefault.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    );
                  }).toList(),
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
                CustomTextField(
                  animatedLabel: true,
                  needOutlineBorder: true,
                  labelText: LocalStrings.description.tr,
                  textInputType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: controller.descriptionFocusNode,
                  controller: controller.descriptionController,
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
                          controller.submitTicket();
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
