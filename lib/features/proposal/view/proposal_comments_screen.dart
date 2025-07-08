import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:legumlex_customer/common/components/custom_fab.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/proposal/controller/proposal_controller.dart';
import 'package:legumlex_customer/features/proposal/repo/proposal_repo.dart';
import 'package:legumlex_customer/features/proposal/widget/add_proposal_comment_bottom_sheet.dart';
import 'package:legumlex_customer/features/proposal/widget/proposal_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ProposalCommentsScreen extends StatefulWidget {
  const ProposalCommentsScreen({super.key, required this.id});
  final String id;

  @override
  State<ProposalCommentsScreen> createState() => _ProposalCommentsScreenState();
}

class _ProposalCommentsScreenState extends State<ProposalCommentsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProposalRepo(apiClient: Get.find()));
    final controller = Get.put(ProposalController(proposalRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProposalDetails(widget.id);
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
                      child:
                          AddProposalCommentBottomSheet(proposalId: widget.id))
                  .customBottomSheet(context);
            },
          ),
        ),
      ),
      body: GetBuilder<ProposalController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : Padding(
                  padding: const EdgeInsets.all(Dimensions.space12),
                  child: RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      controller.loadProposalDetails(widget.id);
                    },
                    child: controller
                            .proposalDetailsModel.data!.comments!.isNotEmpty
                        ? ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return ProposalComment(
                                index: index,
                                proposalDetailsModel:
                                    controller.proposalDetailsModel,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space10),
                            itemCount: controller
                                .proposalDetailsModel.data!.comments!.length)
                        : const NoDataWidget(),
                  ),
                );
        },
      ),
    );
  }
}
