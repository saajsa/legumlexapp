import 'package:legumlex_customer/common/components/app-bar/custom_appbar.dart';
import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/common/components/no_data.dart';
import 'package:legumlex_customer/core/service/api_service.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/features/knowledge/controller/knowledge_controller.dart';
import 'package:legumlex_customer/features/knowledge/model/knowledge_model.dart';
import 'package:legumlex_customer/features/knowledge/repo/knowledge_repo.dart';
import 'package:legumlex_customer/features/knowledge/widget/knowledgebase_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KnowledgeRepo(apiClient: Get.find()));
    final controller = Get.put(KnowledgeController(knowledgeRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocalStrings.knowledgeBase.tr,
      ),
      body: GetBuilder<KnowledgeController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : RefreshIndicator(
                  onRefresh: () async {
                    await controller.initialData(shouldLoad: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: controller.knowledgeBaseModel.message !=
                            "data_not_found"
                        ? SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      const AllKnowledgeBaseFilter(),
                                      ...List.generate(
                                        controller
                                            .knowledgeBaseModel.data!.length,
                                        (index) => KnowledgeBaseFilter(
                                          data: controller
                                              .knowledgeBaseModel.data![index],
                                          index: index,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return KnowledgeBaseCard(
                                          index: index,
                                          knowledgeBaseModel:
                                              controller.knowledgeBaseModel,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              height: Dimensions.space10),
                                      itemCount: controller
                                          .knowledgeBaseModel.data!.length),
                                )
                              ],
                            ),
                          )
                        : const NoDataWidget(),
                  ),
                );
        },
      ),
    );
  }
}

class KnowledgeBaseFilter extends StatelessWidget {
  const KnowledgeBaseFilter(
      {super.key, required this.data, required this.index});
  final Data data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KnowledgeController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            if (index == -1) {
              controller.changeColorListNameTimeline(index);
              controller.initialData(shouldLoad: true);
            } else {
              controller.changeColorListNameTimeline(index);
              controller.getKnowledgeBaseByGroupSlugName(
                  controller.knowledgeBaseModel.data![index].groupSlug!
                  //.capitalizeFirstLetter(),
                  );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Chip(
              labelPadding: const EdgeInsets.all(2.0),
              label: Text(
                data.name!,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: controller.selectButton == index
                  ? ColorResources.primaryColor
                  : ColorResources.blueGreyColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.space10),
            ),
          ),
        );
      },
    );
  }
}

class AllKnowledgeBaseFilter extends StatelessWidget {
  const AllKnowledgeBaseFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return KnowledgeBaseFilter(
      data: Data(
          name: 'All',
          groupId: '',
          groupSlug: '',
          description: '',
          active: '',
          color: '',
          groupOrder: '',
          articles: []),
      index: -1,
    );
  }
}
