import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/style.dart';

class DashboardConsultationPreview extends StatelessWidget {
  final String tag;
  final String phase;
  final String clientName;
  final String note;
  final String dateAdded;
  final int documentCount;
  final VoidCallback? onTap;

  const DashboardConsultationPreview({
    super.key,
    required this.tag,
    required this.phase,
    required this.clientName,
    required this.note,
    required this.dateAdded,
    required this.documentCount,
    this.onTap,
  });

  Color _getPhaseColor(String phase) {
    switch (phase.toLowerCase()) {
      case 'consultation':
        return ColorResources.blueColor;
      case 'litigation':
        return ColorResources.redColor;
      case 'disposed':
        return ColorResources.greenColor;
      default:
        return ColorResources.blueGreyColor;
    }
  }

  String _formatPhase(String phase) {
    return phase.split('_').map((word) => 
        word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : ''
    ).join(' ');
  }

  String _formatDate(String date) {
    if (date.length >= 10) {
      return date.substring(0, 10);
    }
    return date;
  }

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
              color: _getPhaseColor(phase),
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
                    tag,
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
                    color: _getPhaseColor(phase).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatPhase(phase),
                    style: lightSmall.copyWith(
                      color: _getPhaseColor(phase),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space8),
            if (note.isNotEmpty)
              Text(
                note,
                style: lightSmall.copyWith(
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _formatDate(dateAdded),
                    style: lightSmall.copyWith(
                      color: Colors.grey[600],
                    ),
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