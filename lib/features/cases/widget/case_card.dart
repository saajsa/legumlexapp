import 'package:flutter/material.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';

class CaseCard extends StatelessWidget {
  final CaseModel caseModel;
  final VoidCallback? onTap;

  CaseCard({required this.caseModel, this.onTap});

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
                      caseModel.caseTitle ?? 'Untitled Case',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (caseModel.caseNumber != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        caseModel.caseNumber!,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.0),
              if (caseModel.courtDisplay != null)
                Text(
                  caseModel.courtDisplay!,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  if (caseModel.clientName != null)
                    Expanded(
                      child: Text(
                        caseModel.clientName!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (caseModel.nextHearingDate != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Next: ${caseModel.nextHearingDate}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (caseModel.dateFiled != null)
                    Text(
                      'Filed: ${caseModel.dateFiled}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  Row(
                    children: [
                      if (caseModel.documentCount != null && caseModel.documentCount! > 0)
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.description,
                                size: 16.0,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                caseModel.documentCount.toString(),
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (caseModel.hearingCount != null && caseModel.hearingCount! > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.gavel,
                              size: 16.0,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              caseModel.hearingCount.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}