import 'package:legumlex_customer/common/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_button.dart';
import 'package:legumlex_customer/common/components/buttons/rounded_loading_button.dart';
import 'package:legumlex_customer/common/components/custom_date_form_field.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/snack_bar/show_custom_snackbar.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_drop_down_text_field.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_multi_drop_down_text_field.dart';
import 'package:legumlex_customer/common/components/text-form-field/custom_text_field.dart';
import 'package:legumlex_customer/core/helper/date_converter.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/model/task_create_model.dart';
import 'package:legumlex_customer/features/project/model/tasks_model.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class TaskDetailsBottomSheet extends StatefulWidget {
  final String projectId;
  final Task taskModel;
  const TaskDetailsBottomSheet(
      {super.key, required this.projectId, required this.taskModel});

  @override
  State<TaskDetailsBottomSheet> createState() => _TaskDetailsBottomSheetState();
}

class _TaskDetailsBottomSheetState extends State<TaskDetailsBottomSheet> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;

    controller.nameController.text = widget.taskModel.name ?? '';
    controller.priorityController.text = widget.taskModel.priority ?? '';
    controller.startDateController.text = widget.taskModel.startDate ?? '';
    controller.dueDateController.text = widget.taskModel.dueDate ?? '';
    controller.descriptionController.text = widget.taskModel.description ?? '';
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectTaskData(widget.projectId);
    });
  }

  @override
  void dispose() {
    Get.find<ProjectController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(builder: (controller) {
      return controller.isLoading
          ? const CustomLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeaderRow(
                  header: LocalStrings.taskDetails.tr,
                  bottomSpace: 0,
                ),
                const SizedBox(height: Dimensions.space20),
                CustomTextField(
                  labelText: LocalStrings.taskTitle.tr,
                  hintText: widget.taskModel.name,
                  readOnly: !controller.editTaskEnable,
                  controller: controller.nameController,
                  focusNode: controller.nameFocusNode,
                  textInputType: TextInputType.text,
                  nextFocus: controller.priorityFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocalStrings.enterTaskTitle.tr;
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
                  labelText: LocalStrings.priority.tr,
                  onChanged: controller.editTaskEnable
                      ? (value) {
                          controller.priorityController.text = value;
                        }
                      : null,
                  selectedValue: controller.priorityController.text,
                  items: controller.taskCreateModel.data?.priority!
                      .map((Priority value) {
                    return DropdownMenuItem(
                      value: value.id,
                      child: Text(
                        value.name ?? '',
                        style: regularDefault.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.space15),
                CustomMultiDropDownTextField(
                    hintText: LocalStrings.selectAssignees.tr,
                    controller: controller.assigneesController,
                    selectedValue:
                        widget.taskModel.assignees!.map((Assignees value) {
                      return DropdownItem(
                          label: '${value.fullName}', value: value.assigneeId);
                    }).toList(),
                    onChanged: (options) {
                      controller.projectAssignees.clear();
                      for (var v in options) {
                        controller.projectAssignees.add(v.value.toString());
                      }
                      debugPrint(controller.projectAssignees.toString());
                    },
                    items: controller.taskCreateModel.data!.projectMembers!
                        .map((ProjectMembers value) {
                      return DropdownItem(
                          label:
                              '${value.staffFirstName} ${value.staffLastName}',
                          value: value.staffId.toString());
                    }).toList()),
                const SizedBox(height: Dimensions.space15),
                CustomDateFormField(
                  labelText: LocalStrings.taskStartDate.tr,
                  initialValue: DateConverter.convertStringToDatetime(
                      controller.startDateController.text),
                  onChanged: controller.editTaskEnable
                      ? (DateTime? value) {
                          controller.startDateController.text =
                              DateConverter.formatDate(value!);
                        }
                      : (DateTime? value) {},
                ),
                const SizedBox(height: Dimensions.space15),
                CustomDateFormField(
                  labelText: LocalStrings.taskDueDate.tr,
                  initialValue: controller.dueDateController.text != ''
                      ? DateConverter.convertStringToDatetime(
                          controller.dueDateController.text)
                      : null,
                  onChanged: controller.editTaskEnable
                      ? (DateTime? value) {
                          controller.dueDateController.text =
                              DateConverter.formatDate(value!);
                        }
                      : (DateTime? value) {},
                ),
                const SizedBox(height: Dimensions.space15),
                CustomTextField(
                  readOnly: !controller.editTaskEnable,
                  labelText: LocalStrings.description.tr,
                  textInputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  focusNode: controller.descriptionFocusNode,
                  controller: controller.descriptionController,
                  onChanged: (value) {
                    return;
                  },
                ),
                const SizedBox(height: Dimensions.space25),
                controller.submitLoading
                    ? const RoundedLoadingBtn()
                    : RoundedButton(
                        text: LocalStrings.editTask.tr,
                        color: controller.editTaskEnable
                            ? ColorResources.primaryColor
                            : ColorResources.textFieldDisableBorderColor,
                        press: () {
                          controller.editTaskEnable
                              ? controller.updateTask(widget.projectId,
                                  widget.taskModel.id, context)
                              : CustomSnackBar.error(errorList: [
                                  LocalStrings.taskUpdateErrorMsg.tr
                                ]);
                        },
                      ),
              ],
            );
    });
  }
}
