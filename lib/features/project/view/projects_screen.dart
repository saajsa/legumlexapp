import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_container.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/project/widget/project_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final homeController =
        Get.put(DashboardController(dashboardRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      homeController.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.projects.tr,
      ),
      body: GetBuilder<DashboardController>(builder: (dashboardController) {
        return GetBuilder<ProjectController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoader()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.initialData(shouldLoad: false);
                      await dashboardController.initialData();
                    },
                    color: Theme.of(context).primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  width: Dimensions.space3,
                                  height: Dimensions.space15,
                                  color: ColorResources.blueColor,
                                ),
                                const SizedBox(width: Dimensions.space5),
                                Text(
                                  LocalStrings.projectSummery.tr,
                                  style: regularLarge.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                              ],
                            ),
                            shape: const Border(),
                            initiallyExpanded: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.notStarted.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .projectsNotStarted
                                                .toString(),
                                            color: ColorResources.blueColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.inProgress.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .projectsInProgress
                                                .toString(),
                                            color: ColorResources.redColor),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.onHold.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .projectsOnHold
                                                .toString(),
                                            color: ColorResources.yellowColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.finished.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .projectsFinished
                                                .toString(),
                                            color: ColorResources.greenColor),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocalStrings.projects.tr,
                                  style: regularLarge.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: TextIcon(
                                      text: LocalStrings.filter.tr,
                                      icon: Icons.sort_outlined),
                                ),
                              ],
                            ),
                          ),
                          controller.projectsModel.status!
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.space15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ProjectCard(
                                      index: index,
                                      projectModel: controller.projectsModel,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: Dimensions.space10),
                                  itemCount:
                                      controller.projectsModel.data!.length)
                              : const NoDataWidget(),
                        ],
                      ),
                    ),
                  );
          },
        );
      }),
    );
  }
}
