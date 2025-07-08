import 'package:legumlex_customer/common/components/custom_loader/custom_loader.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/knowledge/controller/knowledge_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KnowledgeBaseDetailsScreen extends StatelessWidget {
  const KnowledgeBaseDetailsScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: ColorResources.primaryColor,
        title: Text(
          LocalStrings.knowledgeBaseDetails.tr,
          style: mediumLarge.copyWith(color: Colors.white),
        ),
      ),
      body: GetBuilder<KnowledgeController>(
        builder: (controller) {
          return controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.knowledgeBaseDetailsModel.data!.subject!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: Dimensions.fontDefault),
                        ),
                        const SizedBox(height: Dimensions.space5),
                        const Divider(
                          color: Colors.grey,
                          endIndent: 150,
                          thickness: .5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.space5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${LocalStrings.taskTitle.tr}: ${controller.knowledgeBaseDetailsModel.data!.subject}',
                                style: const TextStyle(
                                    fontSize: Dimensions.fontSmall,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: Dimensions.space5),
                              Text(
                                '${LocalStrings.startDate.tr}: ${controller.knowledgeBaseDetailsModel.data!.subject}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        //Html(data: cubit.knowledgebaseDetailsModel!.data!.subject!),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
