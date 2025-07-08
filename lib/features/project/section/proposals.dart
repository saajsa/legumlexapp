import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/proposal/widget/proposal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProposalsWidget extends StatefulWidget {
  const ProposalsWidget({super.key, required this.id});
  final String id;

  @override
  State<ProposalsWidget> createState() => _ProposalsWidgetState();
}

class _ProposalsWidgetState extends State<ProposalsWidget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectProposals(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? const CustomLoader()
              : controller.proposalsModel.status ?? false
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await controller.loadProjectProposals(widget.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return ProposalCard(
                                  index: index,
                                  proposalModel: controller.proposalsModel);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space10),
                            itemCount: controller.proposalsModel.data!.length),
                      ),
                    )
                  : const Center(child: NoDataWidget()),
        );
      },
    );
  }
}
