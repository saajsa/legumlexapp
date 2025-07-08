import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/custom_fab.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/project/widget/create_task_bottom_sheet.dart';
import 'package:legumlex_customer/features/project/widget/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key, required this.id});
  final String id;

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;
    super.initState();
    handleScroll();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectTasks(widget.id);
    });
  }

  bool showFab = true;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (showFab) setState(() => showFab = false);
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!showFab) setState(() => showFab = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? const CustomLoader()
              : controller.tasksModel.status ?? false
                  ? RefreshIndicator(
                      color: ColorResources.primaryColor,
                      onRefresh: () async {
                        await controller.loadProjectTasks(widget.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.space10),
                        child: ListView.separated(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                  index: index,
                                  projectId: widget.id,
                                  tasksModel: controller.tasksModel);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space5),
                            itemCount: controller.tasksModel.data!.length),
                      ),
                    )
                  : const Center(child: NoDataWidget()),
          floatingActionButton: controller.createTaskEnable
              ? AnimatedSlide(
                  offset: showFab ? Offset.zero : const Offset(0, 2),
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedOpacity(
                    opacity: showFab ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: CustomFAB(
                      icon: Icons.add,
                      isShowText: true,
                      text: LocalStrings.createNewTask.tr,
                      press: () {
                        CustomBottomSheet(
                            child: CreateTaskBottomSheet(
                          projectId: widget.id,
                        )).customBottomSheet(context);
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
