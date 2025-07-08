import 'package:legumlex_customer/common/components/divider/custom_divider.dart';
import 'package:legumlex_customer/common/components/text/text_icon.dart';
import 'package:legumlex_customer/core/helper/date_converter.dart';
import 'package:legumlex_customer/core/helper/string_format_helper.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:legumlex_customer/features/ticket/model/ticket_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TicketReply extends StatelessWidget {
  const TicketReply({
    super.key,
    required this.index,
    required this.ticketDetailsModel,
  });
  final int index;
  final TicketDetailsModel ticketDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(Dimensions.space10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.space10, horizontal: Dimensions.space5),
            child: Html(
              data:
                  ticketDetailsModel.data!.ticketReplies?[index].message ?? '',
              //style: regularSmall,
            ),
          ),
          ticketDetailsModel.data!.ticketReplies![index].attachments!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index2) {
                    return InkWell(
                      onTap: () {},
                      child: TextIcon(
                        text: ticketDetailsModel.data!.ticketReplies![index]
                                .attachments![index2].fileName ??
                            '',
                        icon: Converter.taskFileType(ticketDetailsModel
                                .data!
                                .ticketReplies![index]
                                .attachments![index2]
                                .fileType ??
                            ''),
                        textStyle: lightSmall,
                      ),
                    );
                  },
                  itemCount: ticketDetailsModel
                      .data!.ticketReplies![index].attachments!.length)
              : const SizedBox.shrink(),
          const CustomDivider(space: Dimensions.space10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextIcon(
                text:
                    ticketDetailsModel.data!.ticketReplies?[index].submitter ??
                        '',
                icon: Icons.account_box_rounded,
                textStyle: const TextStyle(
                    fontSize: Dimensions.fontSmall,
                    color: ColorResources.blueGreyColor),
              ),
              const SizedBox(
                width: Dimensions.space15,
              ),
              TextIcon(
                text: DateConverter.formatValidityDate(
                    ticketDetailsModel.data!.ticketReplies![index].date!),
                icon: Icons.calendar_month,
                textStyle: const TextStyle(
                    fontSize: Dimensions.fontSmall,
                    color: ColorResources.blueGreyColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
