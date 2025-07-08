import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/features/knowledge/model/knowledge_model.dart';
import 'package:flutter/material.dart';

class KnowledgeBaseCard extends StatelessWidget {
  const KnowledgeBaseCard({
    super.key,
    required this.index,
    required this.knowledgeBaseModel,
  });
  final int index;
  final KnowledgeBasesModel knowledgeBaseModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*KnowledgeBaseCubit.get(context).getKnowledgeBaseDetails(articles.slug);
        navigateTo(
            context,
            KnowledgeBaseDetailsScreen(
              title: articles.subject!,
            ));*/
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.15),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        knowledgeBaseModel
                            .data![index].articles!.first.subject!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          knowledgeBaseModel
                              .data![index].articles!.first.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: Dimensions.fontDefault,
                              color: ColorResources.blueGreyColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TextIcon(
                      //   text: groupName.capitalizeFirstLetter(),
                      //   prefix: const Icon(
                      //     Icons.account_box_rounded,
                      //     color: ColorResources.primaryColor,
                      //     size: 16,
                      //   ),
                      //   edgeInsets: EdgeInsets.zero,
                      //   textStyle: TextStyle(
                      //       fontSize: 11.sp,
                      //       color: ColorResources.blueGreyColor),
                      // ),
                      const SizedBox(width: Dimensions.space10),
                      TextIcon(
                        text: knowledgeBaseModel
                                .data![index].articles!.first.dateCreated ??
                            '-',
                        icon: Icons.calendar_month,
                        textStyle: const TextStyle(
                            fontSize: Dimensions.fontDefault,
                            color: ColorResources.blueGreyColor),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
