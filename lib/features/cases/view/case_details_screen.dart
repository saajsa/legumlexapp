import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legumlex_customer/features/cases/controller/cases_controller.dart';
import 'package:legumlex_customer/features/cases/model/case_model.dart';
import 'package:legumlex_customer/features/cases/model/document_model.dart';
import 'package:legumlex_customer/features/cases/widget/hearing_card.dart';
import 'package:legumlex_customer/features/cases/widget/document_card.dart';

class CaseDetailsScreen extends StatefulWidget {
  const CaseDetailsScreen({super.key});
  
  @override
  _CaseDetailsScreenState createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late CaseModel caseModel;
  late CasesController casesController;

  @override
  void initState() {
    super.initState();
    caseModel = Get.arguments as CaseModel;
    _tabController = TabController(length: 2, vsync: this);
    
    // Initialize controller
    casesController = Get.put(CasesController());
    
    // Fetch case details, hearings, and documents
    WidgetsBinding.instance.addPostFrameCallback((_) {
      casesController.fetchCaseById(caseModel.id ?? 0);
      casesController.fetchCaseHearings(caseModel.id ?? 0);
      casesController.fetchCaseDocuments(caseModel.id ?? 0);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(caseModel.caseTitle ?? 'Case Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Details'),
            Tab(text: 'Hearings & Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCaseDetailsTab(),
          _buildHearingsAndDocumentsTab(),
        ],
      ),
    );
  }

  Widget _buildCaseDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCaseInfoCard(),
          SizedBox(height: 16.0),
          _buildCourtInfoCard(),
          SizedBox(height: 16.0),
          _buildClientInfoCard(),
        ],
      ),
    );
  }

  Widget _buildHearingsAndDocumentsTab() {
    return GetBuilder<CasesController>(
      builder: (casesController) {
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Hearings'),
                  Tab(text: 'Documents'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildHearingsList(casesController),
                    _buildDocumentsList(casesController),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCaseInfoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            _buildInfoRow('Case Title', caseModel.caseTitle ?? 'N/A'),
            _buildInfoRow('Case Number', caseModel.caseNumber ?? 'N/A'),
            _buildInfoRow('Date Filed', caseModel.dateFiled ?? 'N/A'),
            _buildInfoRow('Date Created', caseModel.dateCreated ?? 'N/A'),
            _buildInfoRow('Status', caseModel.status ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildCourtInfoCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Court Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            _buildInfoRow('Court Name', caseModel.courtName ?? 'N/A'),
            _buildInfoRow('Court No', caseModel.courtNo ?? 'N/A'),
            _buildInfoRow('Judge Name', caseModel.judgeName ?? 'N/A'),
            _buildInfoRow('Court Display', caseModel.courtDisplay ?? 'N/A'),
            _buildInfoRow('Next Hearing Date', caseModel.nextHearingDate ?? 'N/A'),
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
            _buildInfoRow('Client Name', caseModel.clientName ?? 'N/A'),
            _buildInfoRow('Contact Name', caseModel.contactName ?? 'N/A'),
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

  Widget _buildHearingsList(CasesController casesController) {
    if (casesController.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (casesController.errorMessage != null) {
      return Center(
        child: Text('Error: ${casesController.errorMessage}'),
      );
    }

    final hearings = casesController.hearings;
    
    if (hearings.isEmpty) {
      return Center(
        child: Text('No hearings found for this case'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: hearings.length,
      itemBuilder: (context, index) {
        final hearing = hearings[index];
        return HearingCard(
          hearing: hearing,
        );
      },
    );
  }

  Widget _buildDocumentsList(CasesController casesController) {
    if (casesController.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (casesController.errorMessage != null) {
      return Center(
        child: Text('Error: ${casesController.errorMessage}'),
      );
    }

    final documents = casesController.documents;
    
    if (documents.isEmpty) {
      return Center(
        child: Text('No documents found for this case'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return DocumentCard(
          document: document,
          onTap: () {
            // Handle document tap
            _handleDocumentTap(document);
          },
        );
      },
    );
  }

  void _handleDocumentTap(DocumentModel document) {
    // Implementation for handling document tap
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening document: ${document.fileName}')),
    );
  }
}