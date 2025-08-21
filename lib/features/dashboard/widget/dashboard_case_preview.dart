import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/style.dart';

class DashboardCasePreview extends StatelessWidget {
  final String caseTitle;
  final String caseNumber;
  final String clientName;
  final String courtDisplay;
  final String? nextHearingDate;
  final int documentCount;
  final VoidCallback? onTap;

  const DashboardCasePreview({
    super.key,
    required this.caseTitle,
    required this.caseNumber,
    required this.clientName,
    required this.courtDisplay,
    this.nextHearingDate,
    required this.documentCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          border: Border(
            left: BorderSide(
              width: 4.0,
              color: ColorResources.secondaryColor,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    caseTitle,
                    style: regularDefault.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.blueColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    caseNumber,
                    style: lightSmall.copyWith(
                      color: ColorResources.blueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space8),
            if (courtDisplay.isNotEmpty)
              Text(
                courtDisplay,
                style: regularSmall.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: Dimensions.space8),
            if (nextHearingDate != null && nextHearingDate!.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.yellowColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: ColorResources.yellowColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Next: $nextHearingDate',
                      style: lightSmall.copyWith(
                        color: ColorResources.yellowColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: Dimensions.space12),
            Row(
              children: [
                Icon(
                  Icons.business_center_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    clientName,
                    style: lightSmall.copyWith(
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (documentCount > 0) ...[
                  Icon(
                    Icons.description,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    documentCount.toString(),
                    style: lightSmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}