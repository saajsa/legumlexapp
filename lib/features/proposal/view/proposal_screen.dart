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
import 'package:legumlex_customer/features/proposal/controller/proposal_controller.dart';
import 'package:legumlex_customer/features/proposal/repo/proposal_repo.dart';
import 'package:legumlex_customer/features/proposal/widget/proposal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({super.key});

  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProposalRepo(apiClient: Get.find()));
    final controller = Get.put(ProposalController(proposalRepo: Get.find()));
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
        title: LocalStrings.proposals.tr,
      ),
      body: GetBuilder<DashboardController>(builder: (dashboardController) {
        return GetBuilder<ProposalController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoader()
                : RefreshIndicator(
                    onRefresh: () async {
                      await dashboardController.initialData();
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
                                  LocalStrings.proposalSummery.tr,
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
                                            name: LocalStrings.open.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .proposalsOpen
                                                .toString(),
                                            color: ColorResources.blueColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.sent.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .proposalsSent
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
                                                .proposalsAccepted
                                                .toString(),
                                            color: ColorResources.greenColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.declined.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .proposalsDeclined
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
                                  LocalStrings.proposals.tr,
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
                          controller.proposalsModel.status!
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.space15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ProposalCard(
                                      index: index,
                                      proposalModel: controller.proposalsModel,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: Dimensions.space10),
                                  itemCount:
                                      controller.proposalsModel.data!.length)
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
