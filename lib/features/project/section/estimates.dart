import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/features/estimate/widget/estimate_card.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimatesWidget extends StatefulWidget {
  const EstimatesWidget({super.key, required this.id});
  final String id;

  @override
  State<EstimatesWidget> createState() => _EstimatesWidgetState();
}

class _EstimatesWidgetState extends State<EstimatesWidget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectEstimates(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? const CustomLoader()
              : controller.estimatesModel.status ?? false
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await controller.loadProjectEstimates(widget.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return EstimateCard(
                                  index: index,
                                  estimateModel: controller.estimatesModel);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space10),
                            itemCount: controller.estimatesModel.data!.length),
                      ),
                    )
                  : const Center(child: NoDataWidget()),
        );
      },
    );
  }
}
