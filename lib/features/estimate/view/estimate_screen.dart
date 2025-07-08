import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_container.dart';
import 'package:legumlex_customer/features/estimate/controller/estimate_controller.dart';
import 'package:legumlex_customer/features/estimate/repo/estimate_repo.dart';
import 'package:legumlex_customer/features/estimate/widget/estimate_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({super.key});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(EstimateRepo(apiClient: Get.find()));
    final controller = Get.put(EstimateController(estimateRepo: Get.find()));
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
        title: LocalStrings.estimates.tr,
      ),
      body: GetBuilder<DashboardController>(builder: (dashboardController) {
        return GetBuilder<EstimateController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoader()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.initialData(shouldLoad: false);
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
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: Dimensions.space5),
                                Text(
                                  LocalStrings.estimateSummery.tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                                            name: LocalStrings.sent.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .estimatesSent
                                                .toString(),
                                            color: ColorResources.blueColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.expired.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .estimatesExpired
                                                .toString(),
                                            color: ColorResources.yellowColor),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.accepted.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .estimatesAccepted
                                                .toString(),
                                            color: ColorResources.greenColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.declined.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .estimatesDeclined
                                                .toString(),
                                            color: ColorResources.redColor),
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
                                  LocalStrings.estimates.tr,
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                          controller.estimatesModel.status ?? false
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.space15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return EstimateCard(
                                      index: index,
                                      estimateModel: controller.estimatesModel,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: Dimensions.space10),
                                  itemCount:
                                      controller.estimatesModel.data!.length)
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
