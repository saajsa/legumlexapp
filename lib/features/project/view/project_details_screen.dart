import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/project/section/discussions.dart';
import 'package:legumlex_customer/features/project/section/estimates.dart';
import 'package:legumlex_customer/features/project/section/invoices.dart';
import 'package:legumlex_customer/features/project/section/overview.dart';
import 'package:legumlex_customer/features/project/section/proposals.dart';
import 'package:legumlex_customer/features/project/section/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.projectDetails.tr,
      ),
      body: GetBuilder<ProjectController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).cardColor,
                  onRefresh: () async {
                    await controller.loadProjectDetails(widget.id);
                  },
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      isScrollable: true,
                      background: Container(color: Theme.of(context).cardColor),
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: ColorResources.blueGreyColor,
                      indicatorColor: ColorResources.secondaryColor,
                      labelPadding: const EdgeInsets.symmetric(
                          vertical: Dimensions.space17,
                          horizontal: Dimensions.space20),
                    ),
                    tabs: [
                      if (controller.projectOverviewEnable)
                        TextIcon(
                          text: LocalStrings.overview.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.grid_view_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                      if (controller.projectTasksEnable)
                        TextIcon(
                          text: LocalStrings.tasks.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.check_circle_outline_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                      if (controller.projectInvoicesEnable)
                        TextIcon(
                          text: LocalStrings.invoices.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.article_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                      if (controller.projectEstimatesEnable)
                        TextIcon(
                          text: LocalStrings.estimates.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.assignment_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                      if (controller.projectDiscussionsEnable)
                        TextIcon(
                          text: LocalStrings.discussion.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.chat_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                      if (controller.projectProposalsEnable)
                        TextIcon(
                          text: LocalStrings.proposals.tr,
                          textStyle: regularLarge.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          icon: Icons.grid_view_outlined,
                          iconSize: 16,
                          space: Dimensions.space10,
                        ),
                    ],
                    views: [
                      if (controller.projectOverviewEnable)
                        OverviewWidget(
                            projectDetailsModel:
                                controller.projectDetailsModel.data!),
                      if (controller.projectTasksEnable)
                        TasksWidget(id: widget.id),
                      if (controller.projectInvoicesEnable)
                        InvoicesWidget(id: widget.id),
                      if (controller.projectEstimatesEnable)
                        EstimatesWidget(id: widget.id),
                      if (controller.projectDiscussionsEnable)
                        DiscussionsWidget(id: widget.id),
                      if (controller.projectProposalsEnable)
                        ProposalsWidget(id: widget.id),
                    ],
                    //onChange: (index) => print(index),
                  ),
                );
        },
      ),
    );
  }
}
