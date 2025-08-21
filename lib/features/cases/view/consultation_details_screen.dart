import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/features/cases/controller/consultations_controller.dart';
import 'package:legumlex_customer/features/cases/model/consultation_model.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  const ConsultationDetailsScreen({super.key});
  
  @override
  _ConsultationDetailsScreenState createState() => _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  late ConsultationModel consultation;
  late ConsultationsController consultationsController;

  @override
  void initState() {
    super.initState();
    consultation = Get.arguments as ConsultationModel;
    
    // Initialize controller
    consultationsController = Get.put(ConsultationsController());
    
    // Fetch consultation details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      consultationsController.fetchConsultationById(consultation.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(consultation.tag ?? 'Consultation Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConsultationInfoCard(),
            SizedBox(height: 16.0),
            _buildClientInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultationInfoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consultation Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            _buildInfoRow('Tag', consultation.tag ?? 'N/A'),
            _buildInfoRow('Date Added', consultation.dateAdded ?? 'N/A'),
            _buildInfoRow('Phase', consultation.phase ?? 'N/A'),
            _buildInfoRow('Document Count', consultation.documentCount?.toString() ?? '0'),
            SizedBox(height: 16.0),
            Text(
              'Note',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(consultation.note ?? 'No note available'),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            _buildInfoRow('Client Name', consultation.clientName ?? 'N/A'),
            _buildInfoRow('Contact Name', consultation.contactName ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}