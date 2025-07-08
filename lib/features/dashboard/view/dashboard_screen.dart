import 'package:cached_network_image/cached_network_image.dart';
import 'package:legumlex_customer/common/components/app-bar/action_button_icon_widget.dart';
import 'package:legumlex_customer/common/components/circle_image_button.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/will_pop_widget.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/images.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/controller/dashboard_controller.dart';
import 'package:legumlex_customer/features/dashboard/repo/dashboard_repo.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_container.dart';
import 'package:legumlex_customer/features/dashboard/widget/custom_linerprogress.dart';
import 'package:legumlex_customer/features/dashboard/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final controller = Get.put(DashboardController(dashboardRepo: Get.find()));
    controller.isLoading = true;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: "",
      child: GetBuilder<DashboardController>(
        builder: (controller) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 50,
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }),
            centerTitle: true,
            title: CachedNetworkImage(
                imageUrl: controller.dashboardModel.data?.perfexLogo ?? '',
                height: 30,
                errorWidget: (ctx, object, trx) {
                  return Image.asset(
                    MyImages.appLogo,
                    height: 30,
                    color: Colors.white,
                  );
                },
                placeholder: (ctx, trx) {
                  return Image.asset(
                    MyImages.appLogo,
                    height: 30,
                    color: Colors.white,
                  );
                }),
            actions: [
              ActionButtonIconWidget(
                pressed: () => Get.toNamed(RouteHelper.settingsScreen),
                icon: Icons.settings,
                size: 35,
                iconColor: Colors.white,
              ),
            ],
          ),
          drawer: HomeDrawer(
            dashboardModel: controller.dashboardModel,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : RefreshIndicator(
                  onRefresh: () async {
                    await controller.initialData(shouldLoad: false);
                  },
                  color: Theme.of(context).primaryColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorResources.blueGreyColor,
                                radius: 42,
                                child: CircleImageWidget(
                                  imagePath:
                                      '${controller.dashboardModel.data!.contactImage}',
                                  isAsset: false,
                                  isProfile: true,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              const SizedBox(width: Dimensions.space20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: '${LocalStrings.welcome.tr} ',
                                      style: regularLarge.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color),
                                    ),
                                    TextSpan(
                                      text: controller.dashboardModel.data!
                                          .contactFirstName,
                                      style: regularLarge.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color),
                                    ),
                                  ])),
                                  const SizedBox(height: Dimensions.space5),
                                  Text(
                                    '${controller.dashboardModel.data!.contactTitle} - ${controller.dashboardModel.data!.clientName}',
                                    style: regularSmall.copyWith(
                                        color: ColorResources.blueGreyColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 3,
                              height: 15,
                              color: ColorResources.secondaryColor,
                            ),
                            const SizedBox(width: Dimensions.space5),
                            Text(
                              LocalStrings.projectSummery.tr,
                              style: regularLarge,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.projectScreen);
                              },
                              child: Text(
                                LocalStrings.viewAll.tr,
                                style: lightSmall.copyWith(
                                    color: ColorResources.blueGreyColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Row(
                          children: [
                            CustomContainer(
                                name: LocalStrings.notStarted.tr,
                                number: controller
                                    .dashboardModel.data!.projectsNotStarted
                                    .toString(),
                                color: ColorResources.blueColor),
                            const SizedBox(width: Dimensions.space10),
                            CustomContainer(
                                name: LocalStrings.inProgress.tr,
                                number: controller
                                    .dashboardModel.data!.projectsInProgress
                                    .toString(),
                                color: ColorResources.redColor),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Row(
                          children: [
                            CustomContainer(
                                name: LocalStrings.onHold.tr,
                                number: controller
                                    .dashboardModel.data!.projectsOnHold
                                    .toString(),
                                color: ColorResources.yellowColor),
                            const SizedBox(width: Dimensions.space10),
                            CustomContainer(
                                name: LocalStrings.finished.tr,
                                number: controller
                                    .dashboardModel.data!.projectsFinished
                                    .toString(),
                                color: ColorResources.greenColor),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Row(
                          children: [
                            Container(
                              width: 3,
                              height: 15,
                              color: ColorResources.secondaryColor,
                            ),
                            const SizedBox(width: Dimensions.space5),
                            Text(
                              LocalStrings.quickInvoices.tr,
                              style: regularLarge,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.invoiceScreen);
                              },
                              child: Text(
                                LocalStrings.viewAll.tr,
                                style: lightSmall.copyWith(
                                    color: ColorResources.blueGreyColor),
                              ),
                            )
                          ],
                        ),
                        CustomLinerProgress(
                          color: ColorResources.redColor,
                          value: controller
                                      .dashboardModel.data!.invoicesUnPaid !=
                                  0
                              ? controller.dashboardModel.data!.invoicesUnPaid!
                                      .toDouble() /
                                  controller.dashboardModel.data!.invoicesTotal!
                                      .toDouble()
                              : 0,
                          name: LocalStrings.unpaid.tr,
                          data:
                              '${controller.dashboardModel.data!.invoicesUnPaid}/${controller.dashboardModel.data!.invoicesTotal}',
                        ),
                        const SizedBox(height: Dimensions.space10),
                        CustomLinerProgress(
                          color: ColorResources.greenColor,
                          value: controller.dashboardModel.data!.invoicesPaid !=
                                  0
                              ? controller.dashboardModel.data!.invoicesPaid!
                                      .toDouble() /
                                  controller.dashboardModel.data!.invoicesTotal!
                                      .toDouble()
                              : 0,
                          name: LocalStrings.paid.tr,
                          data:
                              '${controller.dashboardModel.data!.invoicesPaid}/${controller.dashboardModel.data!.invoicesTotal}',
                        ),
                        const SizedBox(height: Dimensions.space10),
                        CustomLinerProgress(
                          color: ColorResources.yellowColor,
                          value: controller
                                      .dashboardModel.data!.invoicesOverdue !=
                                  0
                              ? controller.dashboardModel.data!.invoicesOverdue!
                                      .toDouble() /
                                  controller.dashboardModel.data!.invoicesTotal!
                                      .toDouble()
                              : 0,
                          name: LocalStrings.overdue.tr,
                          data:
                              '${controller.dashboardModel.data!.invoicesOverdue}/${controller.dashboardModel.data!.invoicesTotal}',
                        ),
                        const SizedBox(height: Dimensions.space10),
                        CustomLinerProgress(
                          color: ColorResources.purpleColor,
                          value: controller.dashboardModel.data!
                                      .invoicesPartiallyPaid !=
                                  0
                              ? controller.dashboardModel.data!
                                      .invoicesPartiallyPaid!
                                      .toDouble() /
                                  controller.dashboardModel.data!.invoicesTotal!
                                      .toDouble()
                              : 0,
                          name: LocalStrings.partialyPaid.tr,
                          data:
                              '${controller.dashboardModel.data!.invoicesPartiallyPaid}/${controller.dashboardModel.data!.invoicesTotal}',
                        ),
                        const SizedBox(height: Dimensions.space10),
                        SfCartesianChart(
                          title: ChartTitle(
                              text: LocalStrings.quickChart.tr,
                              textStyle: Theme.of(context).textTheme.bodyLarge),
                          plotAreaBorderWidth: 0,
                          series: controller.invoicesChart(),
                          primaryXAxis: const CategoryAxis(
                              arrangeByIndex: true,
                              labelStyle: regularSmall,
                              majorGridLines: MajorGridLines(width: 0),
                              labelIntersectAction:
                                  AxisLabelIntersectAction.multipleRows,
                              edgeLabelPlacement: EdgeLabelPlacement.shift),
                          primaryYAxis: const NumericAxis(
                              labelFormat: '{value}',
                              interval: 2,
                              labelStyle: regularSmall,
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          tooltipBehavior: TooltipBehavior(enable: true),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
