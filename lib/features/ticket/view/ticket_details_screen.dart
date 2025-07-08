import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/card/custom_card.dart';
import 'package:legumlex_customer/common/components/custom_fab.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/common/components/text/default_text.dart';
import 'package:legumlex_customer/core/helper/date_converter.dart';
import 'package:legumlex_customer/core/helper/string_format_helper.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/ticket/controller/ticket_controller.dart';
import 'package:legumlex_customer/features/ticket/repo/ticket_repo.dart';
import 'package:legumlex_customer/features/ticket/widget/add_reply_bottom_sheet.dart';
import 'package:legumlex_customer/features/ticket/widget/ticket_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TicketRepo(apiClient: Get.find()));
    final controller = Get.put(TicketController(ticketRepo: Get.find()));
    controller.isLoading = true;
    super.initState();
    handleScroll();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadTicketDetails(widget.id);
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
        title: LocalStrings.ticketDetails.tr,
      ),
      floatingActionButton: AnimatedSlide(
        offset: showFab ? Offset.zero : const Offset(0, 2),
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: showFab ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: CustomFAB(
            icon: Icons.reply,
            isShowText: true,
            text: LocalStrings.reply.tr,
            press: () {
              CustomBottomSheet(child: AddReplyBottomSheet(ticketId: widget.id))
                  .customBottomSheet(context);
            },
          ),
        ),
      ),
      body: GetBuilder<TicketController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : Padding(
                  padding: const EdgeInsets.all(Dimensions.space12),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.loadTicketDetails(widget.id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#${controller.ticketDetailsModel.data?.id} - ${controller.ticketDetailsModel.data?.subject}',
                              style: mediumLarge,
                            ),
                            Text(
                              controller.ticketDetailsModel.data?.statusName?.tr
                                      .capitalize ??
                                  '',
                              style: mediumDefault.copyWith(
                                  color: ColorResources.ticketStatusColor(
                                      controller.ticketDetailsModel.data
                                              ?.status ??
                                          '')),
                            )
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10),
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocalStrings.department.tr,
                                      style: lightSmall),
                                  Text(LocalStrings.service.tr,
                                      style: lightSmall),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      controller.ticketDetailsModel.data
                                              ?.departmentName ??
                                          '-',
                                      style: regularDefault),
                                  Text(
                                      controller.ticketDetailsModel.data
                                              ?.serviceName ??
                                          '-',
                                      style: regularDefault),
                                ],
                              ),
                              const CustomDivider(space: Dimensions.space10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LocalStrings.submitted.tr,
                                      style: lightSmall),
                                  Text(LocalStrings.priority.tr,
                                      style: lightSmall),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      DateConverter.formatValidityDate(
                                          controller.ticketDetailsModel.data!
                                                  .dateCreated ??
                                              ''),
                                      style: regularDefault),
                                  Text(
                                      controller.ticketDetailsModel.data
                                              ?.priorityName ??
                                          '-',
                                      style: regularDefault),
                                ],
                              ),
                              const CustomDivider(space: Dimensions.space10),
                              Text(LocalStrings.description.tr,
                                  style: lightSmall),
                              Text(
                                  Converter.parseHtmlString(controller
                                          .ticketDetailsModel.data?.message ??
                                      '-'),
                                  maxLines: 2,
                                  style: regularDefault),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.space10,
                                horizontal: Dimensions.space5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                    text: LocalStrings.ticketReplies.tr),
                                const CustomDivider(space: 5),
                              ],
                            )),
                        controller.ticketDetailsModel.data!.ticketReplies!
                                .isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                    controller: scrollController,
                                    itemBuilder: (context, index) {
                                      return TicketReply(
                                        index: index,
                                        ticketDetailsModel:
                                            controller.ticketDetailsModel,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                            height: Dimensions.space10),
                                    itemCount: controller.ticketDetailsModel
                                        .data!.ticketReplies!.length),
                              )
                            : const NoDataWidget(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
