import 'package:flutter/material.dart';
import 'package:legumlex_customer/core/utils/color_resources.dart';
import 'package:legumlex_customer/core/utils/dimensions.dart';
import 'package:legumlex_customer/core/utils/style.dart';

class DashboardProjectPreview extends StatelessWidget {
  final String projectName;
  final String clientName;
  final String status;
  final double progress;
  final String startDate;
  final VoidCallback? onTap;

  const DashboardProjectPreview({
    super.key,
    required this.projectName,
    required this.clientName,
    required this.status,
    required this.progress,
    required this.startDate,
    this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status.toString()) {
      case '1': // Not Started
        return ColorResources.blueColor;
      case '2': // In Progress
        return ColorResources.redColor;
      case '3': // On Hold
        return ColorResources.yellowColor;
      case '4': // Finished
        return ColorResources.greenColor;
      default:
        return ColorResources.blueGreyColor;
    }
  }

  String _formatStatus(String status) {
    switch (status.toString()) {
      case '1':
        return 'Not Started';
      case '2':
        return 'In Progress';
      case '3':
        return 'On Hold';
      case '4':
        return 'Finished';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          border: Border(
            left: BorderSide(
              width: 4.0,
              color: _getStatusColor(status),
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
                    projectName,
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
                    color: _getStatusColor(status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatStatus(status),
                    style: lightSmall.copyWith(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: lightSmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${progress.toInt()}%',
                  style: lightSmall.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: progress / 100,
                backgroundColor: ColorResources.lightBlueGreyColor,
                valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor(status)),
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
                Text(
                  startDate,
                  style: lightSmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}