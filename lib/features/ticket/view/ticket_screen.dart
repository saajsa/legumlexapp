import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/custom_fab.dart';
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
import 'package:legumlex_customer/features/ticket/controller/ticket_controller.dart';
import 'package:legumlex_customer/features/ticket/repo/ticket_repo.dart';
import 'package:legumlex_customer/features/ticket/widget/create_ticket_bottom_sheet.dart';
import 'package:legumlex_customer/features/ticket/widget/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TicketRepo(apiClient: Get.find()));
    final controller = Get.put(TicketController(ticketRepo: Get.find()));
    Get.put(DashboardRepo(apiClient: Get.find()));
    final homeController =
        Get.put(DashboardController(dashboardRepo: Get.find()));
    controller.isLoading = true;
    super.initState();
    handleScroll();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
      homeController.initialData();
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
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.tickets.tr,
      ),
      floatingActionButton: AnimatedSlide(
        offset: showFab ? Offset.zero : const Offset(0, 2),
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: showFab ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: CustomFAB(
            icon: Icons.add,
            isShowText: true,
            text: LocalStrings.createNewTicket.tr,
            press: () {
              CustomBottomSheet(child: const CreateTicketBottomSheet())
                  .customBottomSheet(context);
            },
          ),
        ),
      ),
      body: GetBuilder<DashboardController>(builder: (dashboardController) {
        return GetBuilder<TicketController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoader()
                : RefreshIndicator(
                    onRefresh: () async {
                      await controller.initialData(shouldLoad: false);
                      dashboardController.initialData();
                    },
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
                                  LocalStrings.ticketSummery.tr,
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
                                            name: LocalStrings.open.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .ticketsOpen
                                                .toString(),
                                            color: ColorResources.blueColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.inProgress.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .ticketsInProgress
                                                .toString(),
                                            color: ColorResources.redColor),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space10),
                                    Row(
                                      children: [
                                        CustomContainer(
                                            name: LocalStrings.answered.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .ticketsAnswered
                                                .toString(),
                                            color: ColorResources.yellowColor),
                                        const SizedBox(
                                            width: Dimensions.space10),
                                        CustomContainer(
                                            name: LocalStrings.closed.tr,
                                            number: dashboardController
                                                .dashboardModel
                                                .data!
                                                .ticketsClosed
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
                                  LocalStrings.tickets.tr,
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
                          controller.ticketsModel.status!
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.space15),
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: scrollController,
                                  itemBuilder: (context, index) {
                                    return TicketCard(
                                      index: index,
                                      ticketModel: controller.ticketsModel,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          height: Dimensions.space10),
                                  itemCount:
                                      controller.ticketsModel.data!.length)
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
