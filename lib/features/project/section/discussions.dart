import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/features/project/controller/project_controller.dart';
import 'package:legumlex_customer/features/project/repo/project_repo.dart';
import 'package:legumlex_customer/features/project/widget/discussion_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscussionsWidget extends StatefulWidget {
  const DiscussionsWidget({super.key, required this.id});
  final String id;

  @override
  State<DiscussionsWidget> createState() => _DiscussionsWidgetState();
}

class _DiscussionsWidgetState extends State<DiscussionsWidget> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProjectRepo(apiClient: Get.find()));
    final controller = Get.put(ProjectController(projectRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProjectDiscussions(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? const CustomLoader()
              : controller.discussionsModel.status ?? false
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await controller.loadProjectDiscussions(widget.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return DiscussionCard(
                                  index: index,
                                  discussionModel: controller.discussionsModel);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: Dimensions.space10),
                            itemCount:
                                controller.discussionsModel.data!.length),
                      ),
                    )
                  : const Center(child: NoDataWidget()),
        );
      },
    );
  }
}
