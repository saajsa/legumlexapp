import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/custom_fab.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/contract/controller/contract_controller.dart';
import 'package:legumlex_customer/features/contract/repo/contract_repo.dart';
import 'package:legumlex_customer/features/contract/widget/add_comment_bottom_sheet.dart';
import 'package:legumlex_customer/features/contract/widget/contract_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ContractCommentsScreen extends StatefulWidget {
  const ContractCommentsScreen({super.key, required this.id});
  final String id;

  @override
  State<ContractCommentsScreen> createState() => _ContractCommentsScreenState();
}

class _ContractCommentsScreenState extends State<ContractCommentsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ContractRepo(apiClient: Get.find()));
    final controller = Get.put(ContractController(contractRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadContractDetails(widget.id);
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
        title: LocalStrings.comments.tr,
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
            text: LocalStrings.addComment.tr,
            press: () {
              CustomBottomSheet(
                      child: AddCommentBottomSheet(contractId: widget.id))
                  .customBottomSheet(context);
            },
          ),
        ),
      ),
      body: GetBuilder<ContractController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : Padding(
                  padding: const EdgeInsets.all(Dimensions.space12),
                  child: RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      controller.loadContractDetails(widget.id);
                    },
                    child: controller
                            .contractDetailsModel.data!.comments!.isNotEmpty
                        ? ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return ContractComment(
                                index: index,
                                contractDetailsModel:
                                    controller.contractDetailsModel,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space10),
                            itemCount: controller
                                .contractDetailsModel.data!.comments!.length)
                        : const NoDataWidget(),
                  ),
                );
        },
      ),
    );
  }
}
