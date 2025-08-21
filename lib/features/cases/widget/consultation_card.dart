import 'package:flutter/material.dart';
import 'package:legumlex_customer/features/cases/model/consultation_model.dart';

class ConsultationCard extends StatelessWidget {
  final ConsultationModel consultation;
  final VoidCallback? onTap;

  const ConsultationCard({super.key, required this.consultation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      consultation.tag ?? 'Untitled Consultation',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (consultation.phase != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: _getPhaseColor(consultation.phase!).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        consultation.phase!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: _getPhaseColor(consultation.phase!),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.0),
              if (consultation.note != null)
                Text(
                  consultation.note!,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  if (consultation.clientName != null)
                    Expanded(
                      child: Text(
                        consultation.clientName!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (consultation.dateAdded != null)
                    Text(
                      _formatDate(consultation.dateAdded!),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (consultation.contactName != null)
                    Text(
                      consultation.contactName!,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  if (consultation.documentCount != null && consultation.documentCount! > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 16.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          consultation.documentCount.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPhaseColor(String phase) {
    switch (phase.toLowerCase()) {
      case 'consultation':
        return Colors.blue;
      case 'litigation':
        return Colors.orange;
      case 'disposed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String date) {
    // Simple date formatting - in a real app, you might want to use a package like intl
    if (date.length >= 10) {
      return date.substring(0, 10); // Return YYYY-MM-DD
    }
    return date;
  }
}