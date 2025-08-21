import 'package:flutter/material.dart';
import 'package:legumlex_customer/features/cases/model/hearing_model.dart';

class HearingCard extends StatelessWidget {
  final HearingModel hearing;

  const HearingCard({super.key, required this.hearing});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hearing',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (hearing.status != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: _getStatusColor(hearing.status!).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      hearing.status!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(hearing.status!),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.0,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 8.0),
                Text(
                  _formatDate(hearing.date ?? ''),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (hearing.time != null) ...[
                  SizedBox(width: 16.0),
                  Icon(
                    Icons.access_time,
                    size: 16.0,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    hearing.time!,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 8.0),
            if (hearing.hearingPurpose != null)
              Text(
                hearing.hearingPurpose!,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[700],
                ),
              ),
            SizedBox(height: 8.0),
            if (hearing.description != null)
              Text(
                hearing.description!,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue;
      case 'adjourned':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'postponed':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    
    // Simple date formatting - in a real app, you might want to use a package like intl
    if (date.length >= 10) {
      return date.substring(0, 10); // Return YYYY-MM-DD
    }
    return date;
  }
}