import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/helper/date_converter.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/project/model/discussions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscussionCard extends StatelessWidget {
  const DiscussionCard({
    super.key,
    required this.index,
    required this.discussionModel,
  });
  final int index;
  final DiscussionsModel discussionModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(
                left: BorderSide(
                  width: 5.0,
                  color: ColorResources.blueColor,
                ),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      child: Text(
                        '${discussionModel.data![index].subject}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: regularLarge,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 1.2,
                      child: Text(
                        '${discussionModel.data![index].description}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: lightDefault.copyWith(
                            color: ColorResources.blueGreyColor),
                      ),
                    ),
                    const CustomDivider(space: Dimensions.space10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIcon(
                          text:
                              '${discussionModel.data![index].totalComments} ${LocalStrings.comments.tr}',
                          icon: Icons.comment_rounded,
                        ),
                        TextIcon(
                          text: DateConverter.formatValidityDate(
                              discussionModel.data![index].dateCreated ?? ''),
                          icon: Icons.calendar_month,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
