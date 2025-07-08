import 'package:legumlex_customer/common/components/circle_image_button.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/dialog/warning_dialog.dart';
import 'package:legumlex_customer/core/route/route.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/dashboard/model/dashboard_model.dart';
import 'package:legumlex_customer/features/menu/controller/menu_controller.dart';
import 'package:legumlex_customer/features/menu/repo/menu_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatefulWidget {
  final DashboardModel dashboardModel;
  const HomeDrawer({required this.dashboardModel, super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(MyMenuController(menuRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMenuController>(
        builder: (menuController) => SafeArea(
              child: Drawer(
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorResources.blueGreyColor,
                            radius: 42,
                            child: CircleImageWidget(
                              imagePath:
                                  '${widget.dashboardModel.data!.contactImage}',
                              isAsset: false,
                              isProfile: true,
                              width: 80,
                              height: 80,
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.space20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.dashboardModel.data!.contactFirstName} ${widget.dashboardModel.data!.contactLastName}',
                                style: semiBoldLarge.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Get.toNamed(RouteHelper.profileScreen);
                                  },
                                  child: Text(
                                    LocalStrings.viewProfile.tr,
                                    style: semiBoldLarge.copyWith(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        decoration: TextDecoration.underline),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    menuController.isLoading
                        ? const CustomLoader()
                        : Column(
                            children: [
                              menuController.isProjectsEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.task_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.projects.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.projectScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              menuController.isInvoicesEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.assignment_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.invoices.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.invoiceScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              menuController.isContractsEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.article_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.contracts.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.contractScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              menuController.isProposalsEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.document_scanner_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.proposals.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.proposalScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              menuController.isSupportEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.confirmation_number_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.tickets.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.ticketScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              menuController.isEstimatesEnable
                                  ? ListTile(
                                      leading: Icon(
                                        Icons.add_chart_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                      ),
                                      title: Text(
                                        LocalStrings.estimates.tr,
                                        style: regularDefault.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Dimensions.space12,
                                        color: ColorResources.contentTextColor,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Get.toNamed(RouteHelper.estimateScreen);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              ListTile(
                                leading: Icon(
                                  Icons.account_circle_outlined,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                                title: Text(
                                  LocalStrings.settings.tr,
                                  style: regularDefault.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: Dimensions.space12,
                                  color: ColorResources.contentTextColor,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.toNamed(RouteHelper.settingsScreen);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.info_outline,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                ),
                                title: Text(
                                  LocalStrings.knowledgeBase.tr,
                                  style: regularDefault.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: Dimensions.space12,
                                  color: ColorResources.contentTextColor,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.toNamed(RouteHelper.knowledgeScreen);
                                },
                              ),
                            ],
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ListTile(
                          leading: const Icon(
                            Icons.logout,
                            size: Dimensions.space20,
                            color: Colors.red,
                          ),
                          title: Text(
                            LocalStrings.logout.tr,
                            style: regularDefault.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          onTap: () {
                            const WarningAlertDialog().warningAlertDialog(
                              context,
                              () {
                                Get.back();
                                menuController.logout();
                              },
                              title: LocalStrings.logoutTitle.tr,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
