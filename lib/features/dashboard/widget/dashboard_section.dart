import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/local_strings.dart';
import 'package:legumlex_customer/core/utils/style.dart';
import 'package:get/get.dart';

class DashboardSection extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  final List<Widget> children;
  final bool isExpanded;

  const DashboardSection({
    super.key,
    required this.title,
    required this.onViewAll,
    required this.children,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 15,
              color: ColorResources.secondaryColor,
            ),
            const SizedBox(width: Dimensions.space5),
            Expanded(
              child: Text(
                title,
                style: regularLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                LocalStrings.viewAll.tr,
                style: lightSmall.copyWith(
                  color: ColorResources.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.space12),
        if (isExpanded)
          Column(
            children: children
                .map((child) => Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.space12),
                      child: child,
                    ))
                .toList(),
          )
        else
          SizedBox(
            height: children.isNotEmpty ? null : 100,
            child: children.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: children
                          .map((child) => Padding(
                                padding: const EdgeInsets.only(right: Dimensions.space12),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: child,
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Center(
                    child: Text(
                      'No data available',
                      style: lightSmall.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
          ),
        const SizedBox(height: Dimensions.space20),
      ],
    );
  }
}